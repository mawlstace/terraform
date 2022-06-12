
resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance
  security_groups = [module.SG.sg_name]
  # [aws_security_group.main.id]
  user_data = <<-EOL
  #!/bin/bash -xe

  apt get update    
  apt-get install -y apache2 
  ls /etc/apache2/  
  EOL
  tags = {
    Name = "web-server"
  }
}


module "SG" {
  source = "../SG"   # i am defening module of securitygroup so i can use output of sg_name which is aws_security_group.main.id 
}

module "elastic-ip" {
  source = "../elastic"
  instance_id = aws_instance.web.id   # i am ppassing a variable from  resource aws_instance.web to elastic-ip modules 
}

output "elastic_ip-1" {
  value = module.elastic-ip.eip_value
}






output "web-public-ip" {
  value = aws_instance.web.public_ip
}

output "web-id" {
  value =  aws_instance.web.id
}

output "aws_security_group" {
  value = aws_instance.web.security_groups
  
}
