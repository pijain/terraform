resource "aws_wafv2_ip_set" "this" {
  for_each = var.ip_set
  name = each.key
  description = each.value.description
  scope = each.value.scope
  ip_address_version = each.value.ip_address_version
  addresses = each.value.addresses
  tags = each.value.tags
}