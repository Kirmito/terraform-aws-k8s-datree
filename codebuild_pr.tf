resource "aws_codebuild_project" "build_pr" {
  name           = var.name
  badge_enabled  = var.badge_enabled
  build_timeout  = var.build_timeout
  queued_timeout = var.queued_timeout
  service_role   = var.codebuild_role

  artifacts {
    encryption_disabled    = false
    override_artifact_name = false
    type                   = "NO_ARTIFACTS"
  }

  cache {
    modes = []
    type  = "NO_CACHE"
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config
    content {
      security_group_ids = vpc_config.value["security_group_ids"]
      subnets            = vpc_config.value["subnets"]
      vpc_id             = vpc_config.value["vpc_id"]
    }
  }

  environment {
    compute_type                = var.compute_type
    image                       = var.image
    image_pull_credentials_type = var.image_pull_credentials_type
    privileged_mode             = var.privileged_mode
    type                        = var.environment_type
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }

    s3_logs {
      encryption_disabled = false
      status              = "DISABLED"
    }
  }

  source {
    buildspec           = local.buildspec_file
    git_clone_depth     = 1
    insecure_ssl        = false
    location            = var.repository_url
    report_build_status = true
    type                = var.source_type

    git_submodules_config {
      fetch_submodules = false
    }
  }
}

resource "aws_codebuild_webhook" "pull_request" {
  project_name = aws_codebuild_project.build_pr.name
  build_type   = "BUILD"
  filter_group {
    filter {
      exclude_matched_pattern = false
      pattern                 = "PULL_REQUEST_UPDATED, PULL_REQUEST_REOPENED, PULL_REQUEST_CREATED"
      type                    = "EVENT"
    }
    filter {
      exclude_matched_pattern = false
      pattern                 = "^refs/heads/${var.branch}$"
      type                    = "BASE_REF"
    }
  }
}
