variable "ami" {
    type =  string 
    default =  "ami-0ee02acd56a52998e"
}

variable "instance" {
    type =  string 
    default =  "t2.micro"
}

variable "DB_name" {
  type = list(string)
}