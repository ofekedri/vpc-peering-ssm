variable "region" {
  default = "eu-west-2"
  type    = string
  description = "Region target to deploy resources"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type    = string
  description = "CIDR block of the VPC"
}


variable "vpc_cidr_peer" {
  type    = string
  description = "CIDR block of peer VPC"
}

variable "common_tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Lab         = "ssm-private-ec2"
  }
  description = "Common tags for resources"
}
