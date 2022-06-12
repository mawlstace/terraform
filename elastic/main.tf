
resource "aws_eip" "eip" {
  instance = var.instance_id    # it will be overriden by the value passed by elastic-ip module in (web main.tf) module 
  
  vpc      = true
}
output "eip_value" {
  value = aws_eip.eip.public_ip
}

