resource "aws_eks_cluster" "eks_cluster" {
    name = "test-cluster"

    access_config {
      authentication_mode = "API"
    }

    role_arn = "arn:aws:iam::910033375058:role/c189544a4890779l12733569t1w910033-LabEksClusterRole-6QsnMBRcOLAd"
    version = "1.31"

    vpc_config {
      subnet_ids = module.vpc.public_subnets
    }
}