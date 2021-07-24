output "ip_set_identifiers" {
  value = aws_wafv2_ip_set.this.*.id
}

output "ip_set_arns" {
  value = aws_wafv2_ip_set.this.*.arn
}