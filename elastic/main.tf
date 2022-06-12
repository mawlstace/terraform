
resource "aws_eip" "eip" {
  instance = var.instance_id
  
  vpc      = true
}
output "eip_value" {
  value = aws_eip.eip.public_ip
}

