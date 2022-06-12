resource "aws_security_group" "main" {
name = "allow traffic"

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

}


output "sg_name" {
  value = aws_security_group.main.name
}