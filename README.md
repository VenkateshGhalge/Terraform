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


### module  in terraform 

Modules are containers for multiple resources that are use together. A module consiste of collection of .tf file kept together in a directory. 
Module are the main way to package and reuse resources confiurations with terraform 

## State file 
 state file store the information of infrastructure it has created. which is used by terraform to update the existing infrastructure. when delete the resources it will check the statefile which infrasturcture need to deleted. state file is created after running terraform apply 

 ### storing the state file 

 state file might have the secert or we don't want to share the information to all the teams, so be should store it safe place 
  
  if we use the git to store the state file, we have to restricted the access to repo, if we are storing the state file to git devops team need to push the statefile to git, or else there will be mistach of the state file
  
  to resolve this issue terraform provides the remote backend, in this we can store the state file in external location like amzone S3 bucket 

  when we are running the terraform init command then terraform will get to know we are using the remote backend, it will look in the s3 bucket for state file 

 ### locking state file 
  we user run the terraform apply they will lock the terraform.tfstate file it will not allow other user to update the state file, as we use the remote backend we can use the dynamodb to hold the lock on the terraform.tfstate file    

  ## Provisioner 

  provisioner is used to run the commands or scripts on either local or remote machines and they can tranfer files from a local environments to a remote one. there are 3 available provisioners: 
  - file (used for copying)
  - local-exec (used for local opertation)
  - remote-exec (used for remote operation)

  we have connection block which is used to connect to the servers. The file provisioner and remote-exec provisioner both operate on target resources created in the future 

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.web.public_dns
  }


  file provisioner is used to copy 

  provisioner "file" {
    source = "path/to/local/apps.py"
    destination = "/app/webapps/apps.py"
  }

  local-exec provisioner is used to log or output the 

  provisioner "local-exec"{
    command = "echo 'Instance created.'"
  }

  Remote-exec provisioner: 

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello Terraform!' > /tmp/hello.txt",
    ]
  }

## Workspace 

terraform workspaces enable us to manage multiple deployments of the same configuration, terrafrom use the default workspace. we can created the workspace for dev, QA and PROD env and use the same terraform code, the state file for respective  workspace the state file will be created 

  below is command to create the workspace 
  terraform workspace new dev 

  it will create the workspace for dev, if we want to switch to dev workspace below is the command 
  terraform workspace select dev 
  
  ## Secrents Mangement in terraform 

  using the hashicrop vault to store the secrent 
  1. we have to create new engine in the vault 
  2. inside the engine create secert 
  3. we have to create the policy 
  4. apply policy to the role 

  we will use the provider as valut for access the secert from vault, to read the data we will use the "data" in the terraform, for creating the resources we will use the "reasource"

  to authenticate with vault we will use auth_login 

  provider "vault" {
    address = "<http://vault_ip_address:port>
    skip_chid_token = true

    auth_login {
      path = "auth/approle/login"

      parameter = {
        role_id = ""
        secert_id =""
      }
    }
  }

  for reading the data form vault 

  data "vault_kv_secret_v2" "example" {
  mount = "kv"
  name  = "testing"
}




