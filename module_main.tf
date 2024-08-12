provider "aws" {
    region = "us-east-1"
}

module "aws_module" {
    source = "aws_module/"
    ami_id = "ami-05fa00d4c63e32376" 
    instance_type_id = "t2.micro"
}