output "primary_failover_record" {
  value = aws_route53_record.primary_failover.fqdn
}

output "secondary_failover_record" {
  value = aws_route53_record.secondary_failover.fqdn
}
