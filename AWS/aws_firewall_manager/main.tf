module "mod_ipset" {
  source = "./modules/wafv2_ipset/"
  ip_set = var.ip_set
}

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
            for_each = action.key == "allow" ? [
              1] : []
            content {}
          }
          dynamic block {
            for_each = action.key == "block" ? [
              1] : []
            content {}
          }
          dynamic count {
            for_each = action.key == "count" ? [
              1] : []
            content {}
          }
        }
      }
      dynamic statement {
        for_each = rule.value.statement
        content {
          dynamic "geo_match_statement" {
            for_each = lookup(statement.value, "geo_match_statement", [])
            content {
              country_codes = split(",", geo_match_statement.value)
            }
          }
          dynamic "ip_set_reference_statement" {
            for_each = lookup(statement.value, "ip_set_reference_statement", [])
            content {
              arn = ""
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

resource "aws_wafv2_rule_group" "test" {
  capacity = 1
  name = "test"
  scope = "test"
  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name = ""
    sampled_requests_enabled = false
  }
  rule {
    name = ""
    priority = 0
    action {}
    statement {
      ip_set_reference_statement {
        arn = ""
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name = ""
      sampled_requests_enabled = false
    }
  }
}
