output "vpc_id" {
    description = "vpc id"
    value = module.vpc.vpc_id
}

output "public_subnets" {
    description = "public subnets"
    value = module.vpc.public_subnets
}

output "private_subnets" {
    description = "private subnets"
    value = module.vpc.private_subnets
}

output "eks_api" {
  description = "Cluster api endpoint"
  value = aws_eks_cluster.eks_cluster.endpoint 
}

output "eks_certificate" {
    description = "Cluster certificate"
    value = aws_eks_cluster.eks_cluster.certificate_authority
}