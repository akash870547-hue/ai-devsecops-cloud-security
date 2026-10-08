output "cloudtrail_name" { value = aws_cloudtrail.this.name }
output "cloudtrail_bucket_name" { value = aws_s3_bucket.cloudtrail.id }
output "config_bucket_name" { value = aws_s3_bucket.config.id }
output "config_role_arn" { value = aws_iam_role.config.arn }
