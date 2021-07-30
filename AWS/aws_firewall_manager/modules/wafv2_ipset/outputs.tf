output "ip_set_identifiers" {
  value = aws_wafv2_ip_set.this.*.id
}

output "ip_set_arns" {
  value = aws_wafv2_ip_set.this.*.arn
}

output "test_output" {
  value = tomap({
    for k in aws_wafv2_ip_set.this : k.name => k.arn
  })
}