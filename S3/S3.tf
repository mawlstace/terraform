provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket_acl" "terraform_bucket_acl" {
  bucket = "terraform-bucket"
  acl    = "private"
}

terraform {
  backend "s3" {
    bucket = "terraform-bucket"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}
