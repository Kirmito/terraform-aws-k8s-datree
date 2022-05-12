# terraform-aws-k8s-datree-codebuild

[![terraform](https://img.shields.io/badge/terraform-v1.1.*-5C4EE5?logo=Terraform)](https://www.terraform.io)

> This repository is a terraform module that controls the versioning for the IaC of resources related to K8S Build PR Pipelines.

## Table of Contents

  - [terraform-aws-k8s-datree-codebuild](#terraform-aws-k8s-datree-codebuild)
  - [Table of Contents](#Table-of-Contents)
  - [Diagram](#Diagram)
  - [Prerequisites](#Prerequisites)
  - [Providers](#Providers)
  - [Inputs](#Inputs)
  - [Outputs](#Outputs)
  - [Example usage](#Example-usage)
  - [Contributing](#Contributing)
  - [Further Reading / Useful Links](#Further-Reading--Useful-Links)

## Diagram

![](./assets/images/diagram.png)

## Prerequisites

You will need the following tools and config properly installed on your computer.

- [Git](http://git-scm.com/)
- [Terraform](https://www.terraform.io/downloads.html)

## How to run this module?

To use this module, it needs to be invoked. Here are some examples:

- [Complete Example](examples/complete/README.md)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.build_pr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_webhook.pull_request](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_webhook) | resource |
| [aws_codestarnotifications_notification_rule.codebuild_pr_notifications](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarnotifications_notification_rule) | resource |
| [aws_ssm_parameter.codebuild_pr_payload_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.codebuild_pr_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_codebuild_role"></a> [codebuild\_role](#input\_codebuild\_role) | Specifies the service role ARN for the codebuild project. | `string` | n/a | yes |
| <a name="input_kms_secrets"></a> [kms\_secrets](#input\_kms\_secrets) | The KMS key alias, id or arn for encrypting SSM Parameters | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A prefix string to name all resources | `string` | n/a | yes |
| <a name="input_repository_url"></a> [repository\_url](#input\_repository\_url) | Location of the source code from git | `string` | n/a | yes |
| <a name="input_arn_chatbot_notification"></a> [arn\_chatbot\_notification](#input\_arn\_chatbot\_notification) | The ARN of the chatbot configuration. | `string` | `""` | no |
| <a name="input_badge_enabled"></a> [badge\_enabled](#input\_badge\_enabled) | Generates a publicly-accessible URL for the projects build badge | `bool` | `false` | no |
| <a name="input_branch"></a> [branch](#input\_branch) | Specifies the full name of the Git Branch | `string` | `"main"` | no |
| <a name="input_build_timeout"></a> [build\_timeout](#input\_build\_timeout) | Number of minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed. | `number` | `60` | no |
| <a name="input_compute_type"></a> [compute\_type](#input\_compute\_type) | Information about the compute resources the build project will use. | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| <a name="input_datree_app_token_path"></a> [datree\_app\_token\_path](#input\_datree\_app\_token\_path) | The SSM Parameter path where Datree APP Token is stored | `string` | `""` | no |
| <a name="input_datree_policy"></a> [datree\_policy](#input\_datree\_policy) | The Datree policy name to execute policy checks. | `string` | `"Default"` | no |
| <a name="input_enable_chatbot_notification"></a> [enable\_chatbot\_notification](#input\_enable\_chatbot\_notification) | Type of repository that contains the source code to be built. Valid values: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB\_ENTERPRISE OR BITBUCKET | `bool` | `false` | no |
| <a name="input_environment_type"></a> [environment\_type](#input\_environment\_type) | Type of build environment to use for related builds. | `string` | `"LINUX_CONTAINER"` | no |
| <a name="input_image"></a> [image](#input\_image) | Docker image to use for this build project. | `string` | `"aws/codebuild/standard:5.0"` | no |
| <a name="input_image_pull_credentials_type"></a> [image\_pull\_credentials\_type](#input\_image\_pull\_credentials\_type) | Type of credentials AWS CodeBuild uses to pull images in your build. | `string` | `"CODEBUILD"` | no |
| <a name="input_privileged_mode"></a> [privileged\_mode](#input\_privileged\_mode) | Whether to enable running the Docker daemon inside a Docker container. | `bool` | `false` | no |
| <a name="input_queued_timeout"></a> [queued\_timeout](#input\_queued\_timeout) | Number of minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out. | `number` | `480` | no |
| <a name="input_source_type"></a> [source\_type](#input\_source\_type) | Type of repository that contains the source code to be built. Valid values: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB\_ENTERPRISE OR BITBUCKET | `string` | `"GITHUB"` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | A VPC Configuration map to deploy CodeBuild in VPC Mode | <pre>list(object({<br>    security_group_ids = list(string)<br>    subnets            = list(string)<br>    vpc_id             = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codebuild_pr_arn"></a> [codebuild\_pr\_arn](#output\_codebuild\_pr\_arn) | ARN of the CodeBuild project. |
