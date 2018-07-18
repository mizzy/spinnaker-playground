resource "aws_s3_bucket" "spinnaker_s3_bucket" {
  bucket = "${var.spinnaker_s3_bucket_name}"
}
