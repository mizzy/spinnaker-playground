output "public_dns" {
  value = "${aws_instance.spinnaker.public_dns}"
}
