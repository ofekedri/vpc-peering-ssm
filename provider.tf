
terraform {
  required_version = ">= 1.0" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.0"
    }
  }
  backend "s3" {
    encrypt = true
  }
}

provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "peer"
  region = "eu-west-2"

}



