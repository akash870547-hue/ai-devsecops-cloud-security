module "vpc" {
  source = "../../modules/vpc"
  project_name = var.project_name
  environment = var.environment
  vpc_cidr = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  single_nat_gateway = var.single_nat_gateway
}

module "iam" {
  source = "../../modules/iam"
  project_name = var.project_name
  environment = var.environment
}

module "ecr" {
  source = "../../modules/ecr"
  project_name = var.project_name
  environment = var.environment
}

module "logging" {
  source = "../../modules/logging"
  project_name = var.project_name
  environment = var.environment
}
