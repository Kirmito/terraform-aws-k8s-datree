resource "aws_ssm_parameter" "codebuild_pr_payload_url" {
  name   = "/${var.name}/${var.branch}/build_pr/payload_url"
  type   = "SecureString"
  value  = aws_codebuild_webhook.pull_request.payload_url
  key_id = var.kms_secrets
}

resource "aws_ssm_parameter" "codebuild_pr_secret" {
  count  = var.source_type == "GITHUB_ENTERPRISE" ? 1 : 0 
  name   = "/${var.name}/${var.branch}/build_pr/secret"
  type   = "SecureString"
  value  = aws_codebuild_webhook.pull_request.secret
  key_id = var.kms_secrets
}
