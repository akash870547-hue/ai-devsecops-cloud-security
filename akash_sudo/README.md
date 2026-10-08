# Akash - Cloud Security Engineer Workstream

This repository contains only my assigned Cloud Security Engineer implementation for the AI-Powered DevSecOps project.

## Scope
- AWS VPC, public/private subnet segmentation and security groups
- IAM roles and least-privilege foundations
- Amazon ECR hardening
- CloudTrail audit logging
- AWS Config configuration/compliance visibility
- EKS security, RBAC and NetworkPolicy (Phase 2)
- Secrets Manager integration (Phase 2/3)

Application development, CI/CD implementation, Prometheus/Grafana/AlertManager and AI assistant work are outside this workstream.

## Phase 1
Terraform-based AWS security foundation is implemented under `terraform/environments/dev`.

> Never commit AWS credentials, secrets, Terraform state or real tfvars.
