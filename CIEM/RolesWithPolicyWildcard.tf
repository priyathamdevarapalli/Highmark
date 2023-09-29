resource "aws_iam_role" "role" {
  name = "RoleA"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    git_repo  = "Highmark"
    yor_trace = "aa542835-d47a-46d6-8b46-f9f9585b3360"
  }
}

resource "aws_iam_policy" "policy" {
  name        = "PolicyA"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
  tags = {
    git_repo  = "Highmark"
    yor_trace = "13c64c3f-a2ee-4001-9c8c-ec235789dcd3"
  }
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}