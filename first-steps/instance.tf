provider "aws" {
  region = "eu-central-1"
}


data "template_file" "startup" {
 template = file("script.sh")
}


resource "aws_instance" "web_instance" {
  ami           = "ami-0d1ddd83282187d18"
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.ssm_ec2_profile.name
  user_data = data.template_file.startup.rendered
  tags = {
    Name = "web_instance"
  }
}


