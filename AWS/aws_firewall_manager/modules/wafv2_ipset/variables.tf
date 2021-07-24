variable "ip_set" {
  description = "configuration for ip set"
  type = any # TODO: Map to proper type mostly list(map(string))
  default = {
    ip_set_demo = {
      description         = "demo"
      scope               = "REGIONAL"
      ip_address_version  = "IPV4"
      addresses           = ["1.2.3.4/32", "5.6.7.8/32"]
      tags                = {
        tag1 = value1
        tag2 = value2
      }
    }
  }
}

//variable "ip_set_name" {
//  description = "A friendly name of the IP set."
//  type = string
//}
//
//variable "ip_set_description" {
//  description = "A friendly description of the IP set."
//  type = string
//  default = null
//}
//
//variable "ip_set_scope" {
//  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application. Valid values are CLOUDFRONT or REGIONAL."
//  type = string
//}
//
//variable "ip_set_ip_address_version" {
//  description = "Specify IPV4 or IPV6. Valid values are IPV4 or IPV6."
//  type = string
//  default = "IPV4"
//}
//
//variable "ip_set_addresses" {
//  description = "Contains an array of strings that specify one or more IP addresses or blocks of IP addresses in Classless Inter-Domain Routing (CIDR) notation."
//  type = list(string)
//}
//
//variable "tags" {
//  description = "An array of key:value pairs to associate with the resource."
//  type = map(string)
//  default = {}
//}