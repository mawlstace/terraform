terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = var.region
}

module "DB-server" {
  source = "./DB"
  DB_name = ["mysql","mariadb","dynamodb"]
  
}
output "private_ip" {
  value = module.DB-server.private-ip
}


