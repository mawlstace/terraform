resource "aws_instance" "DB" {
  ami           = var.ami
  instance_type = var.instance

  tags = {
    Name = "DB-server"
  }
}
output "private-ip" {
  value = aws_instance.DB.private_ip
}