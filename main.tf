# Define required providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.3.0"
}

# Set up providers for multiple regions
provider "aws" {
  alias  = "primary"
  region = "us-east-1"
}

provider "aws" {
  alias  = "secondary"
  region = "us-west-2"
}

# Deploy DynamoDB Global Tables
module "dynamodb" {
  source   = "./modules/dynamodb"
  providers = {
    aws.primary   = aws.primary
    aws.secondary = aws.secondary
  }
  table_name = "WeatherData"
  regions    = ["us-east-1", "us-west-2"]
}

# Deploy API Gateway and Lambda in the primary region
module "api_primary" {
  source           = "./modules/api"
  providers        = { aws = aws.primary }
  api_name         = "WeatherAPI"
  dynamodb_table   = module.dynamodb.global_table_primary
  lambda_zip       = "${path.module}/lambda/lambda.zip"
}

# Deploy API Gateway and Lambda in the secondary region
module "api_secondary" {
  source           = "./modules/api"
  providers        = { aws = aws.secondary }
  api_name         = "WeatherAPI"
  dynamodb_table   = module.dynamodb.global_table_secondary
  lambda_zip       = "${path.module}/lambda/lambda.zip"
}


module "dynamodb" {
  source      = "./modules/dynamodb"
  table_name  = "WeatherData"
  regions     = ["us-east-1", "us-west-2"]
}

# Call the route53 module
module "route53" {
  source = "./modules/route53"

  zone_id                    = var.zone_id
  domain_name                = var.domain_name
  primary_region_endpoint    = var.primary_region_endpoint
  secondary_region_endpoint  = var.secondary_region_endpoint
  primary_region_zone_id     = var.primary_region_zone_id
  secondary_region_zone_id   = var.secondary_region_zone_id
}