variable "project_name" { type = string }
variable "environment" { type = string }
variable "application_secret_arn" {
  type        = string
  description = "Exact Secrets Manager ARN the application workload may read."
  default     = "arn:aws:secretsmanager:ap-south-1:000000000000:secret:REPLACE_ME"
}
