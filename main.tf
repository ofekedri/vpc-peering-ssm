
module "region-1" {
  source   = "./ssm-private-ec2"
  region   = var.region-1.region
  vpc_cidr = var.region-1.vpc_cidr
  vpc_cidr_peer = var.region-2.vpc_cidr
}



module "region-2" {
  source   = "./ssm-private-ec2"
  region   =  var.region-2.region
  vpc_cidr =  var.region-2.vpc_cidr
  vpc_cidr_peer = var.region-1.vpc_cidr
}
