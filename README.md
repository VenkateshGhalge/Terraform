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



