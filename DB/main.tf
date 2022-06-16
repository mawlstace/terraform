resource "aws_instance" "DB" {
  ami           = var.ami
  instance_type = var.instance
  count         = length(var.DB_name)

  tags = {
    Name = var.DB_name[count.index]
  }
}
output "private-ip" {
  value = aws_instance.DB.*.private_ip
}