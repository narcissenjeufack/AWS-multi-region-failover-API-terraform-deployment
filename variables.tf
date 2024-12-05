variable "region_primary" {
  default = "us-east-1" # Put the region you want
  description = "Primary AWS region"
}

variable "region_secondary" {
  default = "us-west-2" # Put the region you want
  description = "Secondary AWS region"
}

variable "zone_id" {
  description = "The ID of the Route 53 hosted zone"
}

variable "domain_name" {
  description = "The domain name for the application"
}

variable "primary_region" {
  description = "The AWS region for the primary endpoint"
}

variable "primary_region_endpoint" {
  description = "The endpoint for the primary region"
}

variable "primary_region_zone_id" {
  description = "The hosted zone ID for the primary region"
}

variable "secondary_region_endpoint" {
  description = "The endpoint for the secondary region"
}

variable "secondary_region_zone_id" {
  description = "The hosted zone ID for the secondary region"
}

