data "template_file" "user_data_1" {
  template = "${file("user_data_1.sh")}"
}

data "template_file" "user_data_2" {
  template = "${file("user_data_2.sh")}"
}

