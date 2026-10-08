output "vpc_id" { value = module.vpc.vpc_id }
output "private_subnet_ids" { value = module.vpc.private_subnet_ids }
output "public_subnet_ids" { value = module.vpc.public_subnet_ids }
output "baseline_security_group_id" { value = module.vpc.baseline_security_group_id }
output "eks_cluster_role_arn" { value = module.iam.eks_cluster_role_arn }
output "eks_node_role_arn" { value = module.iam.eks_node_role_arn }
output "ecr_repository_url" { value = module.ecr.repository_url }
output "cloudtrail_name" { value = module.logging.cloudtrail_name }
