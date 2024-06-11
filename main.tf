terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
    source = "./vpc"
}

module "sg" {
    source = "./sg"
    vpc_id = module.vpc.vpc_id
}

module "ec2" {
    source = "./ec2"
    sg_id = module.sg.sg_id
    private_subnet_id = module.vpc.private_subnet_id


}

