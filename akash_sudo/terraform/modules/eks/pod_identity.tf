resource "aws_eks_pod_identity_association" "app" {
  cluster_name    = aws_eks_cluster.this.name
  namespace       = "ai-devsecops"
  service_account = "app"
  role_arn        = var.app_pod_identity_role_arn

  depends_on = [aws_eks_node_group.system]
}
