AWS Secrets Manager Security Model

Application secrets must live in AWS Secrets Manager, never in Git, Dockerfiles, Terraform variables, ConfigMaps, or source code.

Access model:
AWS Secrets Manager -> EKS Pod Identity or IRSA -> dedicated ServiceAccount -> named secret ARN

Controls:
- IAM policy limited to GetSecretValue for named secret ARNs.
- No wildcard secret access.
- KMS encryption where required.
- CloudTrail monitoring for Secrets Manager API activity.
- Rotation for credentials that support rotation.
- Never commit real secret values.