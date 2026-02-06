resource "aws_iam_role" "ecsTaskRole" {
  name = var.task_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ecs-tasks.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_xray" {
  role       = aws_iam_role.ecsTaskRole.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

resource "aws_iam_role_policy" "ecs_task_service" {
  name   = "CruddurTaskRole-Service-Policy"
  role   = aws_iam_role.ecsTaskRole.id
  policy = data.aws_iam_policy_document.task_combined.json
}

data "aws_iam_policy_document" "task_combined" {
  source_policy_documents = [
    data.aws_iam_policy_document.task_ssm.json,
    data.aws_iam_policy_document.task_secrets.json,
    data.aws_iam_policy_document.task_dynamodb.json,
    # data.aws_iam_policy_document.task_s3.json
  ]
}

data "aws_iam_policy_document" "task_ssm" {
  statement {
    sid    = "ReadAppConfigFromSSM"
    effect = "Allow"

    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath"
    ]

    resources = [
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:/cruddur/backend-flask/*"
    ]
  }
}

data "aws_iam_policy_document" "task_secrets" {
  statement {
    sid    = "ReadSecrets"
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue"
    ]

    resources = [
      "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:cruddur/backend-flask/*"
    ]
  }
}

data "aws_iam_policy_document" "task_dynamodb" {
  statement {
    sid    = "DynamoDBAccess"
    effect = "Allow"

    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:Query"
    ]

    resources = [
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/cruddur-messages-prod"
    ]
  }
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# data "aws_iam_policy_document" "task_s3" {
#   statement {
#     sid    = "S3Access"
#     effect = "Allow"

#     actions = [
#       "s3:GetObject",
#       "s3:PutObject"
#     ]

#     resources = [
#       "arn:aws:s3:::cruddur-assets/*"
#     ]
#   }
# }

