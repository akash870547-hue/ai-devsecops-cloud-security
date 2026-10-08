#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-ai-devsecops-dev}"
NAMESPACE="${NAMESPACE:-ai-devsecops}"
ECR_REPOSITORY="${ECR_REPOSITORY:-ai-devsecops/dev/app}"

echo "[1/9] EKS endpoint"
aws eks describe-cluster --name "$CLUSTER_NAME" --query 'cluster.resourcesVpcConfig.{public:endpointPublicAccess,private:endpointPrivateAccess}' --output table

echo "[2/9] EKS control-plane logs"
aws eks describe-cluster --name "$CLUSTER_NAME" --query 'cluster.logging.clusterLogging' --output json

echo "[3/9] EKS secrets encryption"
aws eks describe-cluster --name "$CLUSTER_NAME" --query 'cluster.encryptionConfig' --output json

echo "[4/9] ECR protection"
aws ecr describe-repositories --repository-names "$ECR_REPOSITORY" --query 'repositories[0].{tagMutability:imageTagMutability,scan:imageScanningConfiguration.scanOnPush,encryption:encryptionConfiguration.encryptionType}' --output table

echo "[5/9] Kubernetes RBAC"
kubectl auth can-i --list --as="system:serviceaccount:$NAMESPACE:app"

echo "[6/9] Network policies"
kubectl get networkpolicy -n "$NAMESPACE"

echo "[7/9] Pod security"
kubectl get namespace "$NAMESPACE" --show-labels

echo "[8/9] Workload security context"
kubectl get deployment security-reference -n "$NAMESPACE" -o jsonpath='{.spec.template.spec.containers[0].securityContext}' || true
echo

echo "[9/9] Pod Identity association"
aws eks list-pod-identity-associations --cluster-name "$CLUSTER_NAME" --query 'associations' --output table
