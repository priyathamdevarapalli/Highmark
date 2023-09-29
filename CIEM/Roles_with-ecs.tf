resource "aws_iam_role" "role" {
  name = "test-ecs"

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
    yor_trace = "0f76fbb4-13a1-4fc9-951c-994f41643fce"
  }
}

resource "aws_iam_policy" "policy" {
  name        = "test-ecs"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecs:ExecuteCommand"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
  tags = {
    git_repo  = "Highmark"
    yor_trace = "b532e9ce-b03d-4630-9116-41bf3520c7ed"
  }
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}