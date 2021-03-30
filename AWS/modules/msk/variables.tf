variable "cluster_name" {
  type = string
  description = "Name of the MSK cluster."
}

variable "kafka_version" {
  type = number
  description = "Desired Kafka software version."
}

variable "number_of_broker_nodes" {
  type = number
  description = "The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets."
  default = 3
}

variable "client_subnets" {
  type = list(string)
  description = "A list of subnets to connect to in client VPC"
  default = []
}

variable "ebs_volume_size" {
  type = number
  description = "The size in GiB of the EBS volume for the data drive on each broker node."
  default = 30
}

variable "instance_type" {
  type = string
  description = "Specify the instance type to use for the kafka brokers. e.g. kafka.m5.large."
  default = "kafka.m5.large"
}

variable "security_groups" {
  type = list(string)
  description = "A list of the security groups to associate with the elastic network interfaces to control who can communicate with the cluster."
  default = []
}

variable "encryption_at_rest_kms_key_arn" {
  type = string
  description = "You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest. If no key is specified, an AWS managed KMS ('aws/msk' managed service) key will be used for encrypting the data at rest."
}

variable "jmx_exporter_enabled_in_broker" {}

variable "node_exporter_enabled_in_broker" {}

variable "cloudwatch_logs" {
  type = map(string)
  default = {}
  description = "Indicates whether you want to enable or disable streaming broker logs to Cloudwatch Logs."
}

variable "firehose_logs" {
  type = map(string)
  default = {}
  description = "Indicates whether you want to enable or disable streaming broker logs to Kinesis Data Firehose."
}

variable "s3_logs" {
  type = map(string)
  default = {}
  description = "Indicates whether you want to enable or disable streaming broker logs to S3."
}