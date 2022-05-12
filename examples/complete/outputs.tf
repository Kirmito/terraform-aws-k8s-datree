output "codebuild_pr_arn" {
  description = "ARN of the CodeBuild project."
  value       = module.k8s_apps_example.codebuild_pr_arn
}
