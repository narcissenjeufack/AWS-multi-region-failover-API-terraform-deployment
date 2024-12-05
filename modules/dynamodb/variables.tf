variable "table_name" {
  description = "Name of the DynamoDB global table"
  type        = string
}

variable "regions" {
  description = "AWS regions for DynamoDB global tables"
  type        = list(string)
  default     = ["us-east-1", "us-west-2"]
}
