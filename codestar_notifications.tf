resource "aws_codestarnotifications_notification_rule" "codebuild_pr_notifications" {
  count       = var.enable_chatbot_notification && var.arn_chatbot_notification != "" ? 1 : 0
  detail_type = "FULL"
  event_type_ids = [
    "codebuild-project-build-state-succeeded",
    "codebuild-project-build-state-failed",
    "codebuild-project-build-state-stopped",
    "codebuild-project-build-state-in-progress",
  ]
  name     = "${var.name}-notifications"
  resource = aws_codebuild_project.build_pr.arn
  status   = "ENABLED"


  target {
    address = var.arn_chatbot_notification
    type    = "AWSChatbotSlack"
  }
}
