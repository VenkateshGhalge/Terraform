# scenario based interview Question 

1.  we have service running on aws, we are using cloudformation as infrastructure as code, now we what to move to  terraform we need to created the state file for services. how that can be achived 

 -> we will use the import command. it will help to import the per-existing cloud resources into terraform state 
    syntax 
     terraform import take 2 arguments 
     - ADDR - the address of the resources in terraform (eg. aws_instances.instance_name)
     - ID - the resource ID in the cloud provider/k8s/database service/vcs service/ etc

     create the main.tf file in which only put the provider and resources which you need to created the state file 
     keep all resources blank like below 

     image/image.png

     we will be inporting the resources with below command 

     terraform import aws_instance.myvm i-03757bbfd3588c5b8
     
     image/image-1.png

     it will create the the terraform state file we will try to plan, in then we will know it will replace the value in main.tf with real value like below 
     image/image-2.png

     we will replace the value in the main.tf   

2. you have multiple environment like dev, stage, QA and PROD for apps and devops team need to used the same code how can we achive this using terraform 

 there 2 part, first we can use the same code using the terraform module 
  terraform modules: they are template which can be used by other team with different configuration, parameter and environment variable in this way we can reuse code. 

  secound part is using the same code in different env we can achive it by Terraform workspace 
  terraform worksapce  is usefull when we want to use the same code for different env, we will create workspace for each env and each env will have there own terraform state file 

3. what is state file in terraform and why it is important in terraform 

    statefile is the current status of the services which are configured by the terraform on the cloud provider, terraform checks the state file before changing any thing on the cloud. terraform get's to know which services are created or running on the cloud, state file is the blueprint that is store by terraform 


4. what are best practice to manage terraform state file ?

   1. Remote backend - store the state file on the remotely (eg. aws s3) for safety, collaboration 
   2. state locking - enable state locking to pevent conflicts in concurrent operations 
   3. access controle - limite the access to the statefile 
   4. automated backup - setup automated backup to pervent data loss

5. There are some bash scripts need to run after creating the resources on the cloud, how can we achive it
 
    you can use the provisioners for execution on the scripts like  local-exec and remote-exec

     local-exec are used to run the command on the local machine and remote-exec is used to run the command on the remote host 
     there is file provisioner also, which is used to copy the file from local machine to remote host 
