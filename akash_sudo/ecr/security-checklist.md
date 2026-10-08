# ECR Security Checklist

- [x] Private repository
- [x] Immutable image tags
- [x] Scan on push
- [x] Customer-managed KMS encryption
- [x] KMS key rotation enabled
- [x] Lifecycle retention policy
- [x] EKS node pull permissions restricted to the exact repository ARN
- [x] Deployment uses an immutable image digest
- [ ] Enhanced ECR/Inspector scanning enabled if the team approves the additional Inspector cost
- [ ] Security findings reviewed before promotion

The basic repository-level scan is enabled by default in this project. Enhanced scanning is intentionally left as an explicit optional control because it adds Amazon Inspector cost.

Never store registry credentials in source code. Prefer AWS IAM-based authentication.
