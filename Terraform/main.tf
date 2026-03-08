module "vpc" {
  source = "git::https://github.com/amitgiri-13/ThreeTierArchitecture.git//terraform/modules/vpc?ref=main"

  # VPC
  vpc_name       = "TestVPC"
  vpc_cidr_block = "10.0.0.0/16"

  # Availability Zones
  number_of_az = 2
  vpc_azs      = ["us-east-1a", "us-east-1b"]

  # Public Subnets
  number_of_public_subnets  = 2
  public_subnets_cidr_block = ["10.0.0.0/24", "10.0.1.0/24"]
  map_public_ip_on_launch   = true

  # Private Subnets
  number_of_private_subnets  = 0
  private_subnets_cidr_block = []
}


module "eks_cluster" {
  source = "./Controlplane"

  cluster_name        = var.cluster_name
  authentication_mode = var.authentication_mode
  eks_version         = var.eks_version
  subnet_ids          = module.vpc.public_subnets
  tags                = var.tags
}

module "admin_access" {
  source       = "./Adminaccess"
  cluster_name = var.cluster_name
  admin_list   = var.admin_list
  tags         = var.tags
}