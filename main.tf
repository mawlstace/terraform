provider "aws" {
  region = "eu-west-2"
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_string" "username" {
  length           = 8
  special          = false
  override_special = false
  
}
 resource "aws_db_instance" "primary-rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "RDS"
  identifier           = "primary-rds"
  username             = random_string.username.result
  password             = random_password.password.result
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

output "password_value" {
  value = random_password.password.result
}  
## this will random a value for password ## however it will stay in shown in the statefile ###
##but atleast it will not be in the repo i will use vault when i start learning it ##

output "username_value" {
  value = random_string.username.result
}
## this will random a string for username just for fun ! ## 

resource "local_file" "password_value" {
    content  = random_password.password.result
    filename = "/home/admin1/Desktop/terraform1/Iam/password.txt"
}

resource "local_file" "username_value" {
    content  = random_string.username.result 
    filename = "/home/admin1/Desktop/terraform1/Iam/user.txt"
}

