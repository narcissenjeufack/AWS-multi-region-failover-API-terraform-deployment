variable "api_name" {
  description = "Name of the API"
  type        = string
}

variable "lambda_zip" {
  description = "Path to the Lambda deployment package"
  type        = string
}

variable "dynamodb_table" {
  description = "DynamoDB table name"
  type        = string
}
