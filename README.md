# Terraform
Terraform is the Infrastructure code tool which enable to provision the servers and services on Cloud 

we can create the resoures with terrform in multiple cloud,

## Terraform files

1. main.tf - it will contain main terraform code 
2. variable.tf - containes the variable declare used in the resource block 
3. provider.tf - containes the terrform block,s3 backend definition provider configuration and aliases
4. *.tfvar - containes the environment-specific default value  

## Command used for terraform  
1. terraform init -> it initialize the project, which will download a plugin called provider 
2. terraform plan -> it create the execution plan, which let's know what are the changes 
3. terraform apply -> it will apply all the resources on the cloud provider it will ask for conformation 
4. terraform destory -> it will destory the all the resources on the provider 

## Provider 

 terraform uses the provider plugin to interact with cloud provider, below is exmaple for multiple-region and multiple-provider 

multiple-region eg- 

 provider "aws"{
    alias = "us-east-1"
    region =  "us-east-1"
}

 provider "aws"{
    alias = "us-west-2"
    region =  "us-west-2"
}

resource "aws_instance" "example1"{
    ami = "ami-05fa00d4c63e32376"
    instance_type = "t2.micro"
    provider = "aws.us-east-1"
}

resource "aws_instance" "example2"{
    ami = "ami-05fa00d4c63e32376"
    instance_type = "t2.micro"
    provider = "aws.us-west-2"
}


multiple-provider

provider "aws" {
    region = "us-east-1"
}

provider "azurerm" {
  subscription_id = "your-azure-subscription-id"
  client_certificate = "your-azure-client-id"
  client_secret = "your-azure-client-secret"
  tenant_id = "your-azure-tenant-id"

}

resource "aws_instance" "exmaple1" {
  ami = "ami-080e1f13689e07408"
  instance_type = "t2.micro"  
}

resource "azurerm_virtual_machine" "example2" {
  name = "exmaple-view"
  location = "eastus"
  size = "Standard_A1"
}

## variables 

Terraform has 2 type of variable input and ouput, to make terraform code resuable we can use the input variable. At it will be flexible for different team to use the same terraform code

### Input Variable 
Input variable can be used to pass vaules into your terraform module or configuration, we are parameterizing the terraform configuration 

we can create the variable block in after provider main.tf, we will created the .tfvar file and store all variable  

below are the argument in the variable block 

default -   if you want to set any default vaule for the variable 
type - we are defining the variable vaule type eg {string, boolen, number }
description - we can use this to explain the where this variable will be used 

### Output Variable 

we can get the output like ip address, port eg  


 provider "aws"{
    region =  "us-east-1"
}

variable "ami_id"{
    description = "EC2 AMI ID"
    type = string
}

variable "instance_type"{
    desciption = " EC2 Instance type"
    type = string 
    default = "t2.micro"
}

resource "aws_instance" "exmaple1" {
  ami = var.ami_id
  instance_type = var.instance_type 
}

output "public_ip"{
    description = "Public IP address of the EC2 intances"
    value = aws_instances.exmaple1.public_ip
}

we will created the terraform.tfvar file and store the value for the variable, variable block will be filled with value from terraform.tfvar. below is eg for tfvar file 


ami_id = "ami-080e1f13689e07408"
instance_type = "t2.micro"

### conditional opreaters 

conditional experssion is used to apply conditionl logic within the configuration. That allows you to make descision or set value based on conditions expression are typically used to control where resources are created or not 

Syntax for conditional experssion in terraform 

condition ? true_value : false_value

