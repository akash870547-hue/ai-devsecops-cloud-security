# Akash - Cloud Security Engineer Workstream

This repository contains only my assigned Cloud Security Engineer implementation for the AI-Powered DevSecOps project.

## Implemented scope
- AWS VPC with public/private subnet segmentation
- IAM roles and least-privilege foundations
- Amazon ECR hardening
- CloudTrail audit logging
- AWS Config foundation
- Secure EKS baseline with private endpoint option
- EKS control-plane audit logging
- KMS encryption for Kubernetes Secrets
- Kubernetes restricted Pod Security baseline
- Least-privilege RBAC
- Default-deny NetworkPolicy baseline
- Secrets Manager access model
- Security validation checklist

## Remaining integration
The final application image, CI/CD deployment and monitoring belong to other team members. My responsibility is to provide the security controls those components consume: IAM, ECR, EKS, RBAC, network isolation, secrets access and audit logging.

## Phase workflow
1. Run Terraform validation and plan.
2. Apply infrastructure only after AWS account/budget approval.
3. Configure EKS access and workload IAM.
4. Replace the reference image with the team's ECR image digest.
5. Apply Kubernetes security manifests.
6. Capture sanitized security evidence.

Never commit AWS credentials, secrets, Terraform state, kubeconfig files or real tfvars.