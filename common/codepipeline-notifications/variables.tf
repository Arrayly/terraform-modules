
# Required
variable "project_name" {
  description = "The project name."
  type        = string
}

variable "image_uri" {
  description = "The image uri to use"
  type        = string
}

variable "codepipeline_arn" {
  description = "The arn of the codepipeline"
  type        = string
}

variable "env" {
  description = "The environment (e.g., prod, dev, etc.)."
  type        = string
}

# Defaults
variable "lambda_timeout" {
  description = "The lambda timeout"
  type        = number
  default     = 10
}

variable "common_tags" {
  description = "Common tags for the resources."
  type        = map(string)
  default     = {}
}

variable "webhook_url" {
  description = "The webhook url for MS Teams channel"
  type        = string
  default     = ""
}

variable "enable_teams_notifications" {
  description = "Whether to enable MS Teams or not."
  type        = bool
  default     = false
}

variable "enable_elastic_search" {
  description = "The webhook url for MS Teams channel"
  type        = bool
  default     = false
}

variable "elastic_search_endpoint" {
  description = "The elasticSearch endpoint for pushing logs to"
  type        = string
  default     = ""
}

variable "elastic_search_api_key" {
  description = "The elasticSearch API Key to use"
  type        = string
  default     = ""
}

variable "allowed_events_pipeline_state" {
  description = "The allowed events for the pipeline state change - CodePipeline Pipeline Execution State Change"
  type        = list(string)
  default     = ["STARTED", "SUCCEEDED"]
}

variable "allowed_events_pipeline_stage" {
  description = "The allowed events for the pipeline stage - CodePipeline Stage Execution State Change "
  type        = list(string)
  default     = ["FAILED"]
}

variable "allowed_events_pipeline_approval" {
  description = "The allowed events for the pipeline actions"
  type        = list(string)
  default     = ["STARTED"]
}
