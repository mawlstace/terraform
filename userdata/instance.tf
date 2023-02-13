resource "aws_instance" "web_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  user_data = "${data.template_file.user_data_1.rendered}${data.template_file.user_data_2.rendered}"
  tags = {
    Name = var.name
  }

}

