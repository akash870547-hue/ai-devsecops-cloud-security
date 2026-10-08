#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-ai-devsecops-dev}"
NAMESPACE="${NAMESPACE:-ai-devsecops}"

echo "[1/7] EKS endpoint"
aws eks describe-cluster --name "$CLUSTER_NAME" --query 'cluster.resourcesVpcConfig.{public:endpointPublicAccess,private:endpointPrivateAccess}' --output table

echo "[2/7] EKS control-plane logs"
aws eks describe-cluster --name "$CLUSTER_NAME" --query 'cluster.logging.clusterLogging' --output json

echo "[3/7] ECR protection"
aws ecr describe-repositories --repository-names "ai-devsecops/dev/app" --query 'repositories[0].{tagMutability:imageTagMutability,scan:imageScanningConfiguration.scanOnPush,encryption:encryptionConfiguration.encryptionType}' --output table

echo "[4/7] Kubernetes RBAC"
kubectl auth can-i --list --as="system:serviceaccount:$NAMESPACE:app"

echo "[5/7] Network policies"
kubectl get networkpolicy -n "$NAMESPACE"

echo "[6/7] Pod security"
kubectl get namespace "$NAMESPACE" --show-labels

echo "[7/7] Workload security context"
kubectl get deployment security-reference -n "$NAMESPACE" -o jsonpath='{.spec.template.spec.containers[0].securityContext}' || true
echo
