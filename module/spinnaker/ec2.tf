resource "aws_instance" "spinnaker" {
  ami = "ami-cbb259b4" # Ubuntu 16.04
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  security_groups = ["${var.security_group}"]
  iam_instance_profile = "${aws_iam_instance_profile.spinnaker.name}"
  
  tags {
    Name = "spinnaker"
  }

  root_block_device {
    volume_size = "${var.volume_size}"
  }
}
