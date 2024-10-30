#-------------------------------------------
# main.tf
# - main terraform module functionality
#--------------------------------------------

#Ec2 Instance
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                   = "ec2-instance"
  ami                    = "ami-06b21ccaeff8cd686"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = ["sg-0a845df0f2a1aeb1d"]
  subnet_id              = "subnet-0e5d455883c706500"
}


# s3bukcet for the state-file
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "s3-bucket-ec2-state-file"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

#DynamoDb table for the state-file-lock
module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]
}