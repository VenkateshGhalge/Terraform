# Arguments in Terraform 

## depends_on

terraform cann't identifiy if any resources depends on another resources, we can use the depends_on meta arguments which will help resoures to wait 

please check the aws/eks/eks.tf for example 

## count 

if we want to created the resoures multpile time, instead of writing resoures block multpile time we can use the count 

resource "aws_instance" "server" {
  count = 4 # create four similar EC2 instances

  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"

  tags = {
    Name = "Server ${count.index}"
  }
}


## life-cycle meta-argument 

lifecycle is a nested block that can appear within a resource block. The lifecycle block and its contents are meta-arguments, available for all resource blocks regardless of type.

The arguments available within a lifecycle block are 
 - create_before_destroy
 - prevent_destroy 
 - ignore_changes 
 - replace_triggered_by

 