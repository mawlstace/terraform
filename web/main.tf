
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
  source = "../SG"
}

module "elastic-ip" {
  source = "../elastic"
  instance_id = aws_instance.web.id
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
