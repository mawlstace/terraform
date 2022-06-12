variable "ami" {
    type =  string 
    default =  "ami-0ee02acd56a52998e"
}

variable "instance" {
    type =  string 
    default =  "t2.micro"
}

variable "instance_id" {
  default = "aws_instance.web.id"
}