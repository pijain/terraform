resource "aws_wafv2_rule_group" "this" {
  capacity = var.capacity
  name = var.name
  scope = var.scope
  description = var.description
  tags = var.tags
  dynamic "visibility_config" {
    for_each = var.visibility_config
    content {
      cloudwatch_metrics_enabled = visibility_config.value.cloudwatch_metrics_enabled
      metric_name = visibility_config.value.metric_name
      sampled_requests_enabled = visibility_config.value.sampled_requests_enabled
    }
  }
  dynamic "rule" {
    for_each = var.rule
    content {
      name = rule.value.name
      priority = rule.value.priority
      dynamic action {
        for_each = rule.value.action_type
        content {
          dynamic allow {
            for_each = action.key == "allow" ? [1] : []
            content {}
          }
          dynamic block {
            for_each = action.key == "block" ? [1] : []
            content {}
          }
          dynamic count {
            for_each = action.key == "count" ? [1] : []
            content {}
          }
        }
      }
      dynamic statement {
        for_each = rule.value.statement
        content {
          dynamic "geo_match_statement" {
            for_each = statement.value.geo_match_statement
            content {
              country_codes = geo_match_statement.value.country_codes
            }
          }
        }
      }
      visibility_config {
        cloudwatch_metrics_enabled = rule.value.visibility_config.cloudwatch_metrics_enabled
        metric_name = rule.value.visibility_config.metric_name
        sampled_requests_enabled = rule.value.visibility_config.sampled_requests_enabled
      }
    }
  }
}