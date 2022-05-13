output "codebuild_pr_arn" {
  description = "ARN of the CodeBuild project."
  value       = aws_codebuild_project.build_pr.arn
}
