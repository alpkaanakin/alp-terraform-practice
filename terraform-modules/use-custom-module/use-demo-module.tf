terraform {
  cloud {
    organization = "akintf"

    workspaces {
      name = "devops-aws-demo-ws"
    }
  }
}
module "Networking" {
    source = "../custom-tf-module"
    aws_region = "eu-central-1"
    name = "demo"
    vpc_cidr = "1.0.0.0/16"
    public_subnets = ["1.0.1.0/24","1.0.2.0/24","1.0.3.0/24"]
    private_subnets = ["1.0.4.0/24","1.0.5.0/24","1.0.6.0/24"]
    availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
    

}