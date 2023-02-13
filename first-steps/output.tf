output "instance_public_ip" {
  value = aws_instance.web_instance.public_ip

}
output "instance_public_id" {
  value = aws_instance.web_instance.id


}
