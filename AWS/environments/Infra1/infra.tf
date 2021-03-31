
// S3 Bucket

module "s3_bucket_for_logs" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-nlb-logs"
  acl    = "log-delivery-write"

  # Allow deletion of non-empty bucket
  force_destroy = true

  attach_elb_log_delivery_policy = true
}

// NLB
//module "nlb" {
//  source  = "terraform-aws-modules/alb/aws"
//  version = "~> 5.0"
//
//  name = "my-nlb"
//
//  load_balancer_type = "network"
//
//  vpc_id  = "vpc-abcde012"
//  subnets = ["subnet-abcde012", "subnet-bcde012a"]
//
//  access_logs = {
//    bucket = "my-nlb-logs"
//  }
//
//  target_groups = [
//    {
//      name_prefix      = "pref-"
//      backend_protocol = "TCP"
//      backend_port     = 80
//      target_type      = "instance"
//      deregistration_delay = 900
//    }
//  ]
//
//  http_tcp_listeners = [
//    {
//      port               = 80
//      protocol           = "TCP"
//      target_group_index = 0
//    }
//  ]
//
//  tags = {
//    Environment = "Test"
//  }
//}

// Cloudwatch log group
resource "aws_cloudwatch_log_group" "someloggroup" {
  name = "someloggroup"
  tags = {
    Environment = "Test"
  }
}

// ASG

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name = "service"

  # Launch configuration
  lc_name = "example-lc"

  image_id        = "ami-ebd02392"
  instance_type   = "m5n.large"
  security_groups = ["sg-12345678"]
  ebs_optimized   = true
  enable_monitoring = true
  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true

    },
  ]
  root_block_device = [
    {
      volume_size = "50"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "example-asg"
  vpc_zone_identifier       = ["subnet-1235678", "subnet-87654321"]
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
  ]

  tags_as_map = {
    extra_tag1 = "extra_value1"
    extra_tag2 = "extra_value2"
  }
}