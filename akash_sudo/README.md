# Akash - Cloud Security Engineer Workstream

This repository contains only my assigned Cloud Security Engineer implementation for the AI-Powered DevSecOps project.

## Security architecture

AWS VPC
-> private subnets
-> EKS
-> hardened managed node group
-> EKS Pod Identity
-> least-privilege application IAM
-> Secrets Manager
-> ECR
-> CloudTrail + AWS Config

## Implemented controls

### AWS foundation
- VPC with public/private subnet segmentation.
- Private worker subnets and NAT egress.
- No unrestricted inbound baseline security group.
- Private Secrets Manager interface endpoint.
- CloudTrail multi-region audit logging.
- AWS Config recording and S3 delivery.
- Versioned and encrypted audit buckets.

### IAM and workload identity
- Dedicated EKS cluster role.
- Dedicated EKS node role.
- ECR pull restricted to the project repository.
- EKS Pod Identity trust and association for the application ServiceAccount.
- Secrets Manager access limited to the application secret ARN.
- Optional EKS Access Entry for an explicitly supplied admin principal.

### EKS
- Kubernetes 1.35 baseline.
- Private API endpoint by default.
- API audit, authenticator, controller manager and scheduler logging.
- Customer-managed KMS key for Kubernetes Secrets encryption.
- Pod Identity Agent managed add-on.
- AL2023 managed node group.
- IMDSv2 required with hop limit 1.
- Managed node scaling 1-3 nodes.

### Kubernetes workload security
- Restricted Pod Security namespace labels.
- Least-privilege Role/RoleBinding.
- Default-deny ingress and egress.
- DNS-only cluster egress plus VPC HTTPS and Pod Identity credential endpoint.
- Non-root container.
- Read-only root filesystem.
- All Linux capabilities dropped.
- Privilege escalation disabled.
- RuntimeDefault seccomp.
- ServiceAccount token auto-mount disabled.
- Resource requests and limits.

### ECR
- Immutable image tags.
- Scan on push.
- Customer-managed KMS encryption.
- 30-image lifecycle retention.
- Deployment should use immutable image digests.

## Secrets workflow

The Terraform code creates the application secret container but never commits a secret value.

Populate the secret after infrastructure creation using AWS Secrets Manager or the team's deployment process. Never place the secret value in Git, Terraform variables, manifests or source code.

## Validation

Run:

bash akash_sudo/security-validation/validate.sh

Also run:

terraform fmt -check -recursive
terraform init
terraform validate
terraform plan

For the private EKS endpoint, kubectl must run from the VPC or a connected network such as a VPN or controlled bastion/SSM host.

## Team boundary

Application development, CI/CD implementation, Prometheus/Grafana/AlertManager and AI assistant work are outside this workstream. This folder supplies the security controls consumed by those components.

Never commit AWS credentials, secrets, Terraform state, kubeconfig files or real tfvars.
