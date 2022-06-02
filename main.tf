provider "aws" {
  region = var.region
}
resource "aws_vpc" "main_vpc" {
  cidr_block       = var.main-vpc
}
### public-subnet## 
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.subnet-public   
  availability_zone = "us-east-1a"                                                               
}
### subnet association ### 
resource "aws_route_table_association" "public" {
  subnet_id     = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
#route_table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = var.route
    gateway_id = aws_internet_gateway.gw.id
  }
}
#nat_gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id
}
# ## security group for ec2 instance
# resource "aws_security_group" "main" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.main_vpc.id
  
#   ingress {
#     description      = "https"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   ingress {
#     description      = "http"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   ingress {
#     description      = "http"
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }



resource "aws_security_group" "main_security_group" {
  name = "allow_tls"
  description = "main security group "
  vpc_id = aws_vpc.main_vpc.id

  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }
#egress_rule(outbound)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main security group"
  }
}






resource "aws_instance" "ec2" {
  
  instance_type = "t2.micro"
  ami = "ami-0ee02acd56a52998e"
  vpc_security_group_ids= ["${aws_security_group.main_security_group.id}"]
  subnet_id=aws_subnet.public.id
  
  key_name="my_key"
  # availability_zone ="us-east-1a"

  root_block_device {
    volume_size           = "20"
    volume_type           = "gp2"
  }

}

resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = "us-east-1a"
  size              = 1
}
resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.ec2.id
}

#elastic_ip
resource "aws_eip" "myeip" {
instance = aws_instance.ec2.id
}
resource "aws_eip" "nat_gateway" {
  vpc = true
}
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id = aws_subnet.public.id
  tags = {
    "Name" = "NatGateway"
  }
}
# just outputing it to the consule not needed but just for info :) 
output "nat_gateway_ip" {
  value = aws_eip.nat_gateway.public_ip
}



# root_block_device {
#     volume_size           = "20"
#     volume_type           = "gp2"
#     encrypted             = true
#     kms_key_id            = aws_kms_key.kopi-kms-key.key_id      
#     delete_on_termination = true
#   }
  # data disk
  # ebs_block_device {
  #   device_name           = "/dev/xvda"
  #   volume_size           = "50"
  #   volume_type           = "gp2"
  #   encrypted             = true
  #   kms_key_id            = aws_kms_key.kopi-kms-key.key_id    
  #   delete_on_termination = true
  # }