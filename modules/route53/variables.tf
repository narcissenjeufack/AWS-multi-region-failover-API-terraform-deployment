variable "zone_id" {
  description = "The ID of the Route 53 hosted zone"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the Route 53 record (e.g., weather.example.com)"
  type        = string
}

variable "primary_region_endpoint" {
  description = "The primary region's endpoint (e.g., API Gateway URL)"
  type        = string
}

variable "secondary_region_endpoint" {
  description = "The secondary region's endpoint (e.g., API Gateway URL)"
  type        = string
}

variable "primary_region_zone_id" {
  description = "The hosted zone ID of the primary region"
  type        = string
}

variable "secondary_region_zone_id" {
  description = "The hosted zone ID of the secondary region"
  type        = string
}

variable "route53_zone_id" {
  description = "The Route 53 hosted zone ID."
  type        = string
}

