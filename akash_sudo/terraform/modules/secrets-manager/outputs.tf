output "application_secret_arn" {
  value = aws_secretsmanager_secret.app.arn
}

output "application_secret_name" {
  value = aws_secretsmanager_secret.app.name
}
