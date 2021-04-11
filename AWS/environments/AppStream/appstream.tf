data "aws_iam_policy_document" "appstream-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_ssm_parameter" "imageId" {
  name = "/shared/windows/image"
}

data "aws_ssm_parameter" "securityGroupId" {
  name = "/shared/windows/image"
}

data "aws_ssm_parameter" "subnetId" {
  name = "/shared/windows/image"
}

resource "aws_iam_role" "appstream_role" {
  name               = "instance_role"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.appstream-assume-role-policy.json
}

resource "aws_cloudformation_stack" "appstream" {
  name = "appstream"
  parameters = {

  }
  template_body = <<STACK
{
  "Parameters" : {
    "ComputeCapacity" : {
      "Type" : "Number",
      "Default" : "1",
      "Description" : "Compute capacity for appstream fleet"
    },
    "DisplayName": {
      "Type" : "String",
      "Default": "appstream",
      "Description" : "The fleet name to display."
    },
    "FleetType": {
      "Type": "String",
      "Default": "ON_DEMAND",
      "Description": "The fleet type.",
      "AllowedValues": ["ALWAYS_ON", "ON_DEMAND"]
    },
    "InstanceType": {
      "Type" : "String",
      "Default" : "stream.standard.small",
      "Description" : "The instance type to use when launching fleet instances",
      "AllowedValues" : ["stream.standard.small","stream.standard.medium","stream.standard.large","stream.compute.large","stream.compute.xlarge","stream.compute.2xlarge","stream.compute.4xlarge","stream.compute.8xlarge","stream.memory.large","stream.memory.xlarge","stream.memory.2xlarge","stream.memory.4xlarge","stream.memory.8xlarge","stream.memory.z1d.large","stream.memory.z1d.xlarge","stream.memory.z1d.2xlarge","stream.memory.z1d.3xlarge","stream.memory.z1d.6xlarge","stream.memory.z1d.12xlarge","stream.graphics-design.large","stream.graphics-design.xlarge","stream.graphics-design.2xlarge","stream.graphics-design.4xlarge","stream.graphics-desktop.2xlarge","stream.graphics.g4dn.xlarge","stream.graphics.g4dn.2xlarge","stream.graphics.g4dn.4xlarge","stream.graphics.g4dn.8xlarge","stream.graphics.g4dn.12xlarge","stream.graphics.g4dn.16xlarge","stream.graphics-pro.4xlarge","stream.graphics-pro.8xlarge","stream.graphics-pro.16xlarge"]
    },
    "StreamView": {
      "Type": "String",
      "Default": "APP",
      "Description": "The AppStream 2.0 view that is displayed to your users when they stream from the fleet. When APP is specified, only the windows of applications opened by users display. When DESKTOP is specified, the standard desktop that is provided by the operating system displays.",
      "AllowedValues": ["APP", "DESKTOP"]
    },
    "Name": {
      "Type": "String",
      "Default": "appstream",
      "Description": "A unique name for the fleet.",
    }
  },
  "Resources" : {
    "appstream": {
      "Type" : "AWS::AppStream::Fleet",
      "Properties" : {
        "ComputeCapacity" : { "Ref" : "ComputeCapacity" },
        "DisplayName" : { "Ref" : "DisplayName" },
        "FleetType" : { "Ref" : "FleetType"},
        "IamRoleArn" : "${aws_iam_role.appstream_role.arn}",
        "ImageArn" : "${data.aws_ssm_parameter.imageId.value}",
        "InstanceType" : { "Ref":  "InstanceType" },
        "Name" : { "Ref":  "Name" },
        "StreamView" : { "Ref":  "StreamView" },
        "Tags" : [
          {
            "Key": "Name",
            "Value": ""
          },
          {
            "Key": "Env",
            "Value": "dev"
          },
          {
            "Key": "Version",
            "Value": ""
          },
          {
            "Key": "Access",
            "Value": ""
          },
          {
            "Key": "DeployTs",
            "Value": ""
          },
          {
            "Key": "OwnerGroup",
            "Value": ""
          },
          {
            "Key": "SecLvl",
            "Value": ""
          },
          {
            "Key": "DataConfidential",
            "Value": ""
          },
          {
            "Key": "DataCompliant",
            "Value": ""
          }
        ],
        "VpcConfig" : {
          "SecurityGroupIds": ["${data.aws_ssm_parameter.securityGroupId}"],
          "SubnetIds": ["${data.aws_ssm_parameter.subnetId}"]
        }
      }
    }
  }
}
STACK
}