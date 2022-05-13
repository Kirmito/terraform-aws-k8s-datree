provider "aws" {
  region  = local.region
  profile = "destination"
  default_tags {
    tags = local.tags
  }
}

locals {
  region      = "us-east-1"
  name_prefix = "k8s-apps-example"
  account_id  = data.aws_caller_identity.this.account_id
  tags = {
    environment = "develop"
    repository  = "k8s-apps"
  }
}

data "aws_caller_identity" "this" {}

resource "aws_kms_key" "secrets" {
  description = "The KMS Key to encrypt SSM Parameters and CodeBuild Artifacts"
}

resource "aws_kms_alias" "secrets" {
  name          = "alias/${local.name_prefix}-kms"
  target_key_id = aws_kms_key.secrets.key_id
}

data "aws_iam_policy_document" "codebuild_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "codebuild_policy" {
  statement {
    sid    = "codebuildPermissions"
    effect = "Allow"
    actions = [
      "codebuild:*",
      "codestar-connections:UseConnection"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "SSMPermissions"
    effect = "Allow"
    actions = [
      "ssm:GetParameters",
    ]
    resources = ["arn:aws:ssm:${local.region}:${local.account_id}:parameter/${local.name_prefix}/datree/*"]
  }

  statement {
    sid    = "cloudwatchPermissions"
    effect = "Allow"
    actions = [
      "logs:*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "kmsPermissions"
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    resources = [aws_kms_key.secrets.arn]
  }
}

resource "aws_iam_role" "codebuild" {
  name                  = "${local.name_prefix}-iamrole-codebuild"
  path                  = "/service-role/"
  force_detach_policies = true
  assume_role_policy    = data.aws_iam_policy_document.codebuild_assume_role.json
}

resource "aws_iam_policy" "codebuild" {
  name   = "${local.name_prefix}-policy-codebuild"
  policy = data.aws_iam_policy_document.codebuild_policy.json
}

resource "aws_iam_role_policy_attachment" "codebuild" {
  policy_arn = aws_iam_policy.codebuild.arn
  role       = aws_iam_role.codebuild.name
}

module "k8s_apps_example" {
  source                = "../../"
  name                  = local.name_prefix
  codebuild_role        = aws_iam_role.codebuild.arn
  repository_url        = "https://github.com/Kirmito/k8s-apps"
  branch                = "main"
  kms_secrets           = aws_kms_alias.secrets.arn
  datree_policy         = "k8s_apps_example"
  datree_app_token_path = "/${local.name_prefix}/datree/APP_TOKEN"
}
