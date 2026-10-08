resource "aws_secretsmanager_secret" "app" {
  name                    = "${var.project_name}/${var.environment}/app"
  description             = "Application secret container. Populate the value manually or through the deployment process."
  recovery_window_in_days = 7
}
