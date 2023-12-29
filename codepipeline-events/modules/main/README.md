<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.CloudWatchRuleApproval](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_rule.codepipeline_pipeline_execution_state_change](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_rule.codepipeline_stage_execution_state_change](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.pipeline_approval_state_change](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_event_target.pipeline_execution_state_change](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_event_target.pipeline_stage_execution_state_change](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy.LambdaRolePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.LambdaBasicExecutionRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.LambdaLoggingRuleAttachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.pipeline_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.PermissionForEventsToInvokeLambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.PermissionForEventsToInvokeLambda2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.PermissionForEventsToInvokeLambda3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_events_pipeline_approval"></a> [allowed\_events\_pipeline\_approval](#input\_allowed\_events\_pipeline\_approval) | The allowed events for the pipeline actions | `list(string)` | <pre>[<br>  "STARTED"<br>]</pre> | no |
| <a name="input_allowed_events_pipeline_stage"></a> [allowed\_events\_pipeline\_stage](#input\_allowed\_events\_pipeline\_stage) | The allowed events for the pipeline stage - CodePipeline Stage Execution State Change | `list(string)` | <pre>[<br>  "FAILED"<br>]</pre> | no |
| <a name="input_allowed_events_pipeline_state"></a> [allowed\_events\_pipeline\_state](#input\_allowed\_events\_pipeline\_state) | The allowed events for the pipeline state change - CodePipeline Pipeline Execution State Change | `list(string)` | <pre>[<br>  "STARTED",<br>  "SUCCEEDED"<br>]</pre> | no |
| <a name="input_codepipeline_arn"></a> [codepipeline\_arn](#input\_codepipeline\_arn) | The arn of the codepipeline | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tags for the resources. | `map(string)` | `{}` | no |
| <a name="input_elastic_search_api_key"></a> [elastic\_search\_api\_key](#input\_elastic\_search\_api\_key) | The elasticSearch API Key to use | `string` | `""` | no |
| <a name="input_elastic_search_endpoint"></a> [elastic\_search\_endpoint](#input\_elastic\_search\_endpoint) | The elasticSearch endpoint for pushing logs to | `string` | `""` | no |
| <a name="input_enable_elastic_search"></a> [enable\_elastic\_search](#input\_enable\_elastic\_search) | The webhook url for MS Teams channel | `bool` | `false` | no |
| <a name="input_enable_teams_notifications"></a> [enable\_teams\_notifications](#input\_enable\_teams\_notifications) | Whether to enable MS Teams or not. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | The environment (e.g., prod, dev, etc.). | `string` | n/a | yes |
| <a name="input_image_uri"></a> [image\_uri](#input\_image\_uri) | The image uri to use | `string` | n/a | yes |
| <a name="input_lambda_timeout"></a> [lambda\_timeout](#input\_lambda\_timeout) | The lambda timeout | `number` | `10` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The project name. | `string` | n/a | yes |
| <a name="input_webhook_url"></a> [webhook\_url](#input\_webhook\_url) | The webhook url for MS Teams channel | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_event_rule_arn_approval"></a> [cloudwatch\_event\_rule\_arn\_approval](#output\_cloudwatch\_event\_rule\_arn\_approval) | The ARN of the CloudWatch Event Rule for pipeline approval events. |
| <a name="output_cloudwatch_event_rule_arn_execution_change"></a> [cloudwatch\_event\_rule\_arn\_execution\_change](#output\_cloudwatch\_event\_rule\_arn\_execution\_change) | The ARN of the CloudWatch Event Rule for pipeline execution state change. |
| <a name="output_cloudwatch_event_rule_arn_stage_change"></a> [cloudwatch\_event\_rule\_arn\_stage\_change](#output\_cloudwatch\_event\_rule\_arn\_stage\_change) | The ARN of the CloudWatch Event Rule for pipeline stage change. |
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | The ARN of the IAM policy attached to the Lambda role. |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The ARN of the IAM role used by the Lambda function. |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The name of the IAM role used by the Lambda function. |
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | The ARN of the Lambda function. |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | The name of the Lambda function. |
<!-- END_TF_DOCS -->