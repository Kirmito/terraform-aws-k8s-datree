locals {
  template_file         = "${path.module}/templates/buildspec_pr.yml"
  datree_app_token_path = coalesce(var.datree_app_token_path, "/${var.name}/datree/APP_TOKEN")

  mappings = {
    DATREE_URL            = "https://get.datree.io"
    DATREE_APP_TOKEN_PATH = local.datree_app_token_path
    DATREE_POLICY         = try("--policy ${var.datree_policy}", "")
  }

  buildspec_file = templatefile(local.template_file, local.mappings)
}
