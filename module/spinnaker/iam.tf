resource "aws_iam_instance_profile" "spinnaker" {
  name  = "spinnaker"
  role = "${aws_iam_role.spinnaker.name}"
}

resource "aws_iam_role" "spinnaker" {
    name = "spinnaker_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
            "ec2.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "spinnaker" {
    name = "spinnaker"
    role = "${aws_iam_role.spinnaker.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
}
