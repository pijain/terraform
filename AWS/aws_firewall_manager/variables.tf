variable "capacity" {
  description = "The web ACL capacity units (WCUs) required for this rule group."
  type = number
  default = 0
}

variable "description" {
  description = "A friendly description of the rule group."
  type = string
  default = ""
}

variable "name" {
  description = "A friendly name of the rule group."
  type = string
}

variable "rule" {
  description = "The rule blocks used to identify the web requests that you want to allow, block, or count."
  default = [
    {
      name = "rule-1"
      priority = 1
      action_type = "allow"
      statement = {
        geo_match_statement = {
          country_codes = ["US", "NL"]
        }
      }
      visibility_config = {
        cloudwatch_metrics_enabled = false
        metric_name = "friendly-metric-name"
        sampled_requests_enabled = false
      }
    }
  ]
}

variable "scope" {
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application. Valid values are CLOUDFRONT or REGIONAL."
  type = string
  default = "REGIONAL"
}

variable "tags" {
  description = "An array of key:value pairs to associate with the resource."
  type = map(string)
  default = {}
}

variable "visibility_config" {
  description = "Defines and enables Amazon CloudWatch metrics and web request sample collection."
  type = list(map(string))
  default = [{
    cloudwatch_metrics_enabled = false
    metric_name = "friendly-metric-name"
    sampled_requests_enabled = false
  }]
}