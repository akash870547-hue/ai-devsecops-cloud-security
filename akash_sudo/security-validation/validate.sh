#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-ai-devsecops-dev}"
NAMESPACE="${NAMESPACE:-ai-devsecops}"
ECR_REPOSITORY="${ECR_REPOSITORY:-ai-devsecops/dev/app}"
SECRET_NAME="${SECRET_NAME:-ai-devsecops/dev/app}"
CONFIG_RECORDER="${CONFIG_RECORDER:-ai-devsecops-dev-config}"
CLOUDTRAIL_NAME="${CLOUDTRAIL_NAME:-ai-devsecops-dev-trail}"

echo "[1/12] EKS endpoint"
aws eks describe-cluster --name "$CLUSTER_NAME" --query 'cluster.resourcesVpcConfig.{public:endpointPublicAccess,private:endpointPrivateAccess}' --output table

echo "[2/12] EKS control-plane logs"
aws eks describe-cluster --name "$CLUSTER_NAME" --query 'cluster.logging.clusterLogging' --output json

echo "[3/12] EKS secrets encryption"
aws eks describe-cluster --name "$CLUSTER_NAME" --query 'cluster.encryptionConfig' --output json

echo "[4/12] EKS Pod Identity agent"
aws eks describe-addon --cluster-name "$CLUSTER_NAME" --addon-name eks-pod-identity-agent --query 'addon.{status:status,version:addonVersion}' --output table

echo "[5/12] EKS access entries"
aws eks list-access-entries --cluster-name "$CLUSTER_NAME" --output table

echo "[6/13] ECR protection"
aws ecr describe-repositories --repository-names "$ECR_REPOSITORY" --query 'repositories[0].{tagMutability:imageTagMutability,scan:imageScanningConfiguration.scanOnPush,encryption:encryptionConfiguration.encryptionType,kms:encryptionConfiguration.kmsKey}' --output table

echo "[7/13] Application secret"
aws secretsmanager describe-secret --secret-id "$SECRET_NAME" --query '{name:Name,arn:ARN,kms:KmsKeyId}' --output table

echo "[8/13] CloudTrail status"
aws cloudtrail get-trail-status --name "$CLOUDTRAIL_NAME" --query '{logging:IsLogging,lastDelivery:LatestDeliveryTime}' --output table

echo "[9/13] AWS Config status"
aws configservice describe-configuration-recorder-status --configuration-recorder-names "$CONFIG_RECORDER" --query 'ConfigurationRecordersStatus[0].{recording:recording,lastStatus:lastStatus}' --output table

echo "[10/13] Kubernetes RBAC"
kubectl auth can-i --list --as="system:serviceaccount:$NAMESPACE:app"

echo "[11/13] Network policies"
kubectl get networkpolicy -n "$NAMESPACE"

echo "[12/13] Pod security labels"
kubectl get namespace "$NAMESPACE" --show-labels

echo "[13/13] Workload security context"
kubectl get deployment security-reference -n "$NAMESPACE" -o jsonpath='{.spec.template.spec.containers[0].securityContext}' || true
echo

echo "Validation complete. Review every output for the expected security posture."
