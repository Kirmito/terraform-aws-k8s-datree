variable "name" {
  type        = string
  description = "A prefix string to name all resources"
}

variable "repository_url" {
  type        = string
  description = "Location of the source code from git"
}

variable "codebuild_role" {
  type        = string
  description = "Specifies the service role ARN for the codebuild project."
}

variable "kms_secrets" {
  type        = string
  description = "The KMS key alias, id or arn for encrypting SSM Parameters"
}

variable "branch" {
  type        = string
  default     = "main"
  description = "Specifies the full name of the Git Branch"
}

variable "badge_enabled" {
  type        = bool
  default     = false
  description = "Generates a publicly-accessible URL for the projects build badge"
}

variable "build_timeout" {
  type        = number
  default     = 60
  description = "Number of minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed."
}

variable "queued_timeout" {
  type        = number
  default     = 480
  description = "Number of minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out."
}

variable "vpc_config" {
  type = list(object({
    security_group_ids = list(string)
    subnets            = list(string)
    vpc_id             = string
  }))
  default     = []
  description = "A VPC Configuration map to deploy CodeBuild in VPC Mode"
}

variable "compute_type" {
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
  description = " Information about the compute resources the build project will use."
}

variable "image" {
  type        = string
  default     = "aws/codebuild/standard:5.0"
  description = "Docker image to use for this build project."
}

variable "image_pull_credentials_type" {
  type        = string
  default     = "CODEBUILD"
  description = "Type of credentials AWS CodeBuild uses to pull images in your build."
}

variable "privileged_mode" {
  type        = bool
  default     = false
  description = "Whether to enable running the Docker daemon inside a Docker container."
}

variable "environment_type" {
  type        = string
  default     = "LINUX_CONTAINER"
  description = "Type of build environment to use for related builds."
}

variable "source_type" {
  type        = string
  default     = "GITHUB"
  description = "Type of repository that contains the source code to be built. Valid values: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE OR BITBUCKET"
}

variable "enable_chatbot_notification" {
  type        = bool
  default     = false
  description = "Type of repository that contains the source code to be built. Valid values: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE OR BITBUCKET"
}

variable "arn_chatbot_notification" {
  type        = string
  default     = ""
  description = "The ARN of the chatbot configuration."
}

variable "datree_app_token_path" {
  type        = string
  default     = ""
  description = "The SSM Parameter path where Datree APP Token is stored"
}

variable "datree_policy" {
  type        = string
  default     = "Default"
  description = "The Datree policy name to execute policy checks."
}
