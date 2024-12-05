# Create the DynamoDB table in the primary region
resource "aws_dynamodb_table" "primary_table" {
  provider     = aws.primary
  name         = "${var.table_name}-primary"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "Location"
    type = "S"
  }

  attribute {
    name = "Timestamp"
    type = "N"
  }

  hash_key       = "Location"
  range_key      = "Timestamp"
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
}

# Create the DynamoDB table in the secondary region
resource "aws_dynamodb_table" "secondary_table" {
  provider     = aws.secondary
  name         = "${var.table_name}-secondary"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "Location"
    type = "S"
  }

  attribute {
    name = "Timestamp"
    type = "N"
  }

  hash_key       = "Location"
  range_key      = "Timestamp"
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
}

# Define the global table to link the primary and secondary tables
resource "aws_dynamodb_global_table" "global_table" {
  provider = aws.primary
  name     = var.table_name

  replica {
    region_name = aws.primary.region
  }

  replica {
    region_name = aws.secondary.region
  }
}

