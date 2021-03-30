resource "aws_msk_cluster" "this" {
  cluster_name = var.cluster_name
  kafka_version = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes
  broker_node_group_info {
    client_subnets = var.client_subnets
    ebs_volume_size = var.ebs_volume_size
    instance_type = var.instance_type
    security_groups = var.security_groups
  }
  encryption_info {
    encryption_at_rest_kms_key_arn = var.encryption_at_rest_kms_key_arn
  }
  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = var.jmx_exporter_enabled_in_broker
      }
      node_exporter {
        enabled_in_broker = var.node_exporter_enabled_in_broker
      }
    }
  }
  logging_info {
    broker_logs {
      dynamic "cloudwatch_logs" {
        for_each = var.cloudwatch_logs
        content {
          enabled = lookup(cloudwatch_logs.value, "enabled", false)
          log_group = lookup(cloudwatch_logs.value, "log_group", null)
        }
      }
      dynamic "firehose" {
        for_each = var.firehose_logs
        content {
          enabled = lookup(firehose_logs, "enabled", false)
          delivery_stream = lookup(firehose_logs, "firehose_delivery_stream_name", null)
        }
      }
      dynamic "s3" {
        for_each = var.s3_logs
        content {
          enabled = lookup(s3_logs, "enabled", false)
          bucket = lookup(s3_logs, "s3_bucket_id", null)
          prefix = lookup(s3_logs, "s3_prefix", null )
        }
      }
    }
  }
}