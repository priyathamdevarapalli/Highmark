resource "aws_iam_user" "user" {
  name          = "${local.resource_prefix.value}-user"
  force_destroy = true

  tags = merge({
    Name        = "${local.resource_prefix.value}-user"
    Environment = local.resource_prefix.value
    }, {
    git_commit           = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file             = "terraform/aws/iam.tf"
    git_last_modified_at = "2020-06-16 14:46:24"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "bridgecrewio"
    git_repo             = "Highmark"
    yor_trace            = "9b45b298-c1ea-426a-9644-610780021eaa"
  })

}

resource "aws_iam_access_key" "user" {
  user = aws_iam_user.user.name
}

resource "aws_iam_user_policy" "userpolicy" {
  name = "excess_policy"
  user = "${aws_iam_user.user.name}"

  policy = {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "ec2:*",
          "s3:*",
          "lambda:*",
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  }
}

resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = aws_iam_role.test_role.id

  # Terraform's "jsonencode" function converts 
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
resource "aws_iam_role" "role" {
  name = "test-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
  tags = {
    git_repo  = "Highmark"
    yor_trace = "22ab228a-bd7f-4efa-9fe9-7e3dfe467050"
  }
}


resource "aws_iam_role" "role" {
  name = "notprincipal"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "NotPrincipal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Deny",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    git_repo  = "Highmark"
    yor_trace = "22ab228a-bd7f-4efa-9fe9-7e3dfe467050"
  }
}

resource "aws_iam_role" "test_role" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key   = "tag-value"
    git_repo  = "Highmark"
    yor_trace = "25e44331-bfde-42aa-9076-d099dfce200d"
  }
}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
  tags = {
    git_repo  = "Highmark"
    yor_trace = "00a6caee-34eb-4c19-94e9-827fc0223072"
  }
}

resource "aws_iam_policy" "policy" {
  name        = "Condition_test_policy"
  description = "My policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow",
        Action   = "iam:*",
        Resource = "aws:*",
      }
    ]
  })
  tags = {
    git_repo  = "Highmark"
    yor_trace = "00a6caee-34eb-4c19-94e9-827fc0223072"
  }
}
##kms actions

resource "aws_iam_policy" "policy" {
  name        = "kms_action"
  description = "My policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow",
        Action   = "*",
        Resource = "kms:Decrypt",
        Condition = {
          BoolIfExists = {
            aws = "MultiFactorAuthPresent"
          }
        }
      }
    ]
  })
  tags = {
    git_repo  = "Highmark"
    yor_trace = "00a6caee-34eb-4c19-94e9-827fc0223072"
  }
}
resource "aws_iam_group_policy" "my_developer_policy" {
  name  = "my_developer_policy"
  group = aws_iam_group.my_developers.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_group" "my_developers" {
  name = "developers"
  path = "/users/"
}
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}
output "username" {
  value = aws_iam_user.user.name
}

output "secret" {
  value = aws_iam_access_key.user.encrypted_secret
}



