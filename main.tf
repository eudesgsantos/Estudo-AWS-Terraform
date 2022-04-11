provider "aws" {
    region = "us-west-2"
}

terraform {
    backend "s3" {
        key = "terraform/tfstate.tfstate"
        bucket = "esantos-remote-backend"
        region = "us-west-2"
        access_key = "x"
        secret_key = "x"
    }
}


module "iam" {
    source = "./iam"
}

module "network" {
    source = "./network"
}

module "security" {
    source = "./security"
    esantosVPC = module.network.esantosVPC 
    depends_on = [module.network]
}

module "ec2" {
    source = "./ec2"
    subnetPrivateA = module.network.subnetPrivateA
    subnetPrivateB = module.network.subnetPrivateB
    subnetPublicA  = module.network.subnetPublicA
    subnetPublicB  = module.network.subnetPublicB
    EC2PrivSecGP = module.security.EC2PrivSecGP 
    EC2PubSecGP = module.security.EC2PubSecGP 
    depends_on = [module.security]
}

module "db"{
    source = "./db"
    DBSecGP = module.security.DBSecGP
    subnetPrivateA = module.network.subnetPrivateA
    subnetPrivateB = module.network.subnetPrivateB
    depends_on = [module.security]
}
