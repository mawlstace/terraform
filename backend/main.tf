provider "aws" {
  region = "eu-west-2"
}

# creating simple vpc 
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
}

# creating mybucket 
resource "aws_s3_bucket" "mybucket" {
  bucket = "mybucket"
  force_destroy = true  ## this is important to destroy the bucket when you use bucket versioning 

  tags = {
    Name        = "My bucket"
  
  }
}
# enable bucket versioing 
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.mybucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# making S3 acl to private 
resource "aws_s3_bucket_acl" "bucket-acl" {
  bucket = aws_s3_bucket.mybucket.id
  acl    = "private"
}

### S3 bucket rule to block all public access 

resource "aws_s3_bucket_public_access_block" "bucket-access" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true 
  restrict_public_buckets = true
} 