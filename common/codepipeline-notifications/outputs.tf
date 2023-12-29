output "lambda_function_name" {
  value       = aws_lambda_function.pipeline_notification.function_name
  description = "The name of the Lambda function."
}

output "lambda_function_arn" {
  value       = aws_lambda_function.pipeline_notification.arn
  description = "The ARN of the Lambda function."
}

output "iam_role_name" {
  value       = aws_iam_role.LambdaBasicExecutionRole.name
  description = "The name of the IAM role used by the Lambda function."
}

output "iam_role_arn" {
  value       = aws_iam_role.LambdaBasicExecutionRole.arn
  description = "The ARN of the IAM role used by the Lambda function."
}

output "iam_policy_arn" {
  value       = aws_iam_policy.LambdaRolePolicy.arn
  description = "The ARN of the IAM policy attached to the Lambda role."
}

output "cloudwatch_event_rule_arn_stage_change" {
  value       = aws_cloudwatch_event_rule.codepipeline_stage_execution_state_change.arn
  description = "The ARN of the CloudWatch Event Rule for pipeline stage change."
}

output "cloudwatch_event_rule_arn_execution_change" {
  value       = aws_cloudwatch_event_rule.codepipeline_pipeline_execution_state_change.arn
  description = "The ARN of the CloudWatch Event Rule for pipeline execution state change."
}

output "cloudwatch_event_rule_arn_approval" {
  value       = aws_cloudwatch_event_rule.CloudWatchRuleApproval.arn
  description = "The ARN of the CloudWatch Event Rule for pipeline approval events."
}