variable "region" {
  default = "us-east-1"
}
variable "main-vpc" {
  default = "10.0.0.0/16"
}

variable "subnet-public" {
  default = "10.0.0.0/24"  
}
variable "route" {
  default = "0.0.0.0/0"
}

variable "sg_ingress_rules" {
  description = "Ingress security group rules"
  type        = map
}


