resource "aws_dynamodb_table" "dynamodb-terraform-state-locking" {
  name = "terraform-state-locking-dynamo" # Change the name accordingly
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    name = "DynamoDB Terraform State Lock Table"
  }
}