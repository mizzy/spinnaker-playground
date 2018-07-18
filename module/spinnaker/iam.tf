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


resource "aws_iam_role" "base_iam_role" {
  name = "BaseIAMRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "spinnaker_assume_role_policy" {
  name = "SpinnakerAssumeRolePolicy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Resource": [
                "arn:aws:iam::${var.managing_account_id}:role/spinnakerManaged",
                "arn:aws:iam::${var.managed_account_id}:role/spinnakerManaged"
            ],
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_user" "spinnaker" {
  name = "Spinnaker"
}

resource "aws_iam_user_policy_attachment" "power_user_access" {
  user       = "${aws_iam_user.spinnaker.name}"
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_user_policy_attachment" "spinnaker_assume_role_policy" {
  user       = "${aws_iam_user.spinnaker.name}"
  policy_arn = "${aws_iam_policy.spinnaker_assume_role_policy.arn}"
}

resource "aws_iam_access_key" "spinnaker" {
  user    = "${aws_iam_user.spinnaker.name}"
}

resource "aws_iam_policy" "spinnaker_pass_role" {
    name        = "SpinnakerPassRole"
    path        = "/"
    description = ""
    policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "iam:PassRole",
      "Resource": "arn:aws:iam::${var.managing_account_id}:role/BaseIAMRole"
    }
  ]
}
EOF
}

resource "aws_iam_role" "spinnaker_managed" {
    name               = "spinnakerManaged"
    path               = "/"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "1",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_user.spinnaker.arn}"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
