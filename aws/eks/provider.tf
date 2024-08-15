provider "aws"{
    region = "us-east-1"
}

terraform {
    required_providers {
        aws = {
            source = "hashicrop/aws"
            version = "~> 3.0"
        }
    }
}