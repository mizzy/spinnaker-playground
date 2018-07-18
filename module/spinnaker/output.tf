output "public_dns" {
  value = "${aws_instance.spinnaker.public_dns}"
}

output "access_key_id" {
  value = "${aws_iam_access_key.spinnaker.id}"
}

output "secret_access_key" {
  value = "${aws_iam_access_key.spinnaker.secret}"
}

output "account_id" {
  value = "${var.managed_account_id}"
}
