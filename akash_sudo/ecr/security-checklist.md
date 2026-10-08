ECR Security Checklist

- Private repository
- Immutable image tags
- Scan on push
- AES-256 repository encryption
- Lifecycle retention policy
- Deploy by immutable image digest
- CI/CD role limited to required repository actions
- EKS workload pull access limited to required repository
- Security findings reviewed before promotion

Never store registry credentials in source code. Prefer AWS IAM-based authentication.
