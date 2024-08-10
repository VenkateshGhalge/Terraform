provider "aws"{
    region =  "us-east-1"
}

resource "aws_instance" "example1"{
    ami = "ami-07c8c1b18ca66bb07"
    instance_type = "t2.micro"

    tags = {
     Name = "TF-instance"
    }
}
