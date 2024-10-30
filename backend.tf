terraform {
  backend "s3" {
    bucket         = "s3-bucket-ec2-state-file"
    key            = "hanuma/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
  }
}