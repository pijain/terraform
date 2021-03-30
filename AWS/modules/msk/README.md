# AWS Managed Streaming Kafka Terraform module

Terraform module which creates Managed Streaming Kafka on AWS with all (or almost all) features provided by Terraform AWS provider.

This type of resources are supported

* [Managed Streaming Kafka](https://aws.amazon.com/msk/)

These features of MSK configuration are available

- Broker node configuration
- Encryption Configuration
- Open Monitoring/Prometheus configurations
- Logging Configuration

## Usage

### MSK with 3 nodes, prometheus monitoring and s3 logging

```hcl
module "msk_cluster" {
  source = "../modules/msk"
  cluster_Name = "TestCluster"
  kafka_version = "2.7.0"
  number_of_broker_nodes = 3
  client_subnets = ["subnet1", "sunbet2", "subnet3"]
  ebs_volume_size = 1000
  security_groups = ["managed_kafka_sg"]
  jmx_exporter_enabled_in_broker = true
  node_exporter_enabled_in_broker = true
  s3_logs = {
    enabled = true
    bucket = "msk_logging_bucket"
    prefix = "msk/"
  }
}
```
