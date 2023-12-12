#Region 1
variable "region-1" {
  type = map
  default = {
    region = "eu-west-1"
    vpc_cidr = "10.0.0.0/16"
    }
}

#Region 2
variable "region-2" {
  type = map
  default = {
    region = "eu-west-2"
    vpc_cidr = "10.1.0.0/16"
    }
}

