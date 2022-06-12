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
}
output "DB-private_ip" {
  value = module.DB-server.private-ip
}


module "web-server" {
  source = "./web"

}


output "instance-web-public-ip" {
  value = module.web-server.web-public-ip

}
output "instance-web-security-group" {
  value = module.web-server.aws_security_group
}


