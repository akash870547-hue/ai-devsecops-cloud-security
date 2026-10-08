variable "aws_region" { type = string default = "ap-south-1" }
variable "project_name" { type = string default = "ai-devsecops" }
variable "environment" { type = string default = "dev" }
variable "vpc_cidr" { type = string default = "10.20.0.0/16" }
variable "availability_zones" { type = list(string) default = ["ap-south-1a", "ap-south-1b"] }
variable "public_subnet_cidrs" { type = list(string) default = ["10.20.1.0/24", "10.20.2.0/24"] }
variable "private_subnet_cidrs" { type = list(string) default = ["10.20.11.0/24", "10.20.12.0/24"] }
variable "single_nat_gateway" { type = bool default = true }
