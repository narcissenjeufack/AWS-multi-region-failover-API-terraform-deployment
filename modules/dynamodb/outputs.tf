# Outputs for the primary and secondary tables
output "global_table_primary" {
  value = aws_dynamodb_table.primary_table.name
}

output "global_table_secondary" {
  value = aws_dynamodb_table.secondary_table.name
}
