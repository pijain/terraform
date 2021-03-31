provider "aws" {
  region = "ap-south-1"
  access_key = "" # Put your access key
  secret_key = "" # Put your secret key
}

//terraform {
// backend "s3" {
//   encrypt = true
//   bucket = "terraform-state"
//   dynamodb_table = "terraform-state-locking-dynamo"
//   region = "us-east-1"
//   key = "initial-setup.state"
// }
//}