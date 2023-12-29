locals {
  pipeline_name = element(split(":", var.codepipeline_arn), 5)
}
data "aws_caller_identity" "current" {}

resource "aws_lambda_function" "pipeline_notification" {
  image_uri     = var.image_uri
  function_name = "${var.project_name}-pipeline-notify-lambda-${var.env}"
  role          = aws_iam_role.LambdaBasicExecutionRole.arn
  timeout       = var.lambda_timeout
  architectures = ["arm64"]
  package_type  = "Image"
  environment {
    variables = {
      TEAMS_WEBHOOK              = var.webhook_url
      ENVIRONMENT                = var.env
      ENABLE_TEAMS_NOTIFICATIONS = var.enable_teams_notifications
      ENABLE_ELASTIC_SEARCH      = var.enable_elastic_search
      ELASTIC_SEARCH_CLOUD_ID    = var.elastic_search_endpoint
      ELASTIC_SEARCH_API_KEY     = var.elastic_search_api_key
    }
  }
  tags = var.common_tags

  depends_on = [
    aws_iam_role_policy_attachment.LambdaLoggingRuleAttachment,
  ]
}

#####################
### IAM Resources ###
#####################
resource "aws_iam_role" "LambdaBasicExecutionRole" {
  name               = "${var.project_name}-lambdaNotifyRole-${var.env}"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.common_tags
}
resource "aws_iam_policy" "LambdaRolePolicy" {
  name        = "${var.project_name}-lambdaNotifyPolicy-${var.env}-2"
  description = "IAM policy for Lambda"
  policy      = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "codepipeline:ListPipelineExecutions",
          "codepipeline:ListActionExecutions",
          "codepipeline:GetPipeline",
          "codepipeline:GetPipelineState",
          "codepipeline:GetPipelineExecution",
          "codepipeline:GetActionType",
          "codepipeline:ListActionTypes"
        ],
        Resource = "arn:aws:codepipeline:*:${data.aws_caller_identity.current.account_id}:*"
      }
    ]
  })

  tags = var.common_tags
}
resource "aws_iam_role_policy_attachment" "LambdaLoggingRuleAttachment" {
  role       = aws_iam_role.LambdaBasicExecutionRole.name
  policy_arn = aws_iam_policy.LambdaRolePolicy.arn
}

########################
### Cloudwatch Rules ###
########################
resource "aws_cloudwatch_event_rule" "codepipeline_stage_execution_state_change" {
  name        = "${var.project_name}-codepipeline-stage-execution-change-${var.env}"
  description = "Pipeline events for stage change"

  event_pattern = jsonencode({
    source      = ["aws.codepipeline"],
    detail-type = ["CodePipeline Stage Execution State Change"],
    resources   = [var.codepipeline_arn],
    detail      = {
      state = var.allowed_events_pipeline_stage
    }
  })
}
resource "aws_cloudwatch_event_rule" "codepipeline_pipeline_execution_state_change" {
  name        = "${var.project_name}-codepipeline-execution-change-${var.env}"
  description = "Pipeline events for state change"

  event_pattern = jsonencode({
    source      = ["aws.codepipeline"],
    detail-type = ["CodePipeline Pipeline Execution State Change"],
    detail      = {
      pipeline : [local.pipeline_name]
      state = var.allowed_events_pipeline_state
    }
  })
}

resource "aws_cloudwatch_event_rule" "CloudWatchRuleApproval" {
  name        = "${var.project_name}-PipelineApproval-${var.env}"
  description = "Pipeline approval events"

  event_pattern = jsonencode({
    source      = ["aws.codepipeline"],
    detail-type = ["CodePipeline Action Execution State Change"],
    detail      = {
      pipeline : [local.pipeline_name]
      state = var.allowed_events_pipeline_approval,
      type  = {
        category = ["Approval"]
      }
    }
  })
}

##########################
### CloudWatch Targets ###
##########################
resource "aws_cloudwatch_event_target" "pipeline_stage_execution_state_change" {
  rule = aws_cloudwatch_event_rule.codepipeline_stage_execution_state_change.name
  arn  = aws_lambda_function.pipeline_notification.arn
}
resource "aws_cloudwatch_event_target" "pipeline_approval_state_change" {
  rule = aws_cloudwatch_event_rule.CloudWatchRuleApproval.name
  arn  = aws_lambda_function.pipeline_notification.arn
}
resource "aws_cloudwatch_event_target" "pipeline_execution_state_change" {
  rule = aws_cloudwatch_event_rule.codepipeline_pipeline_execution_state_change.name
  arn  = aws_lambda_function.pipeline_notification.arn
}

#########################
### Lambda Permission ###
#########################
resource "aws_lambda_permission" "PermissionForEventsToInvokeLambda" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.pipeline_notification.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.codepipeline_stage_execution_state_change.arn
}
resource "aws_lambda_permission" "PermissionForEventsToInvokeLambda2" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.pipeline_notification.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.CloudWatchRuleApproval.arn
}
resource "aws_lambda_permission" "PermissionForEventsToInvokeLambda3" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.pipeline_notification.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.codepipeline_pipeline_execution_state_change.arn
}