provider "aws"{
    region =  "us-east-1"
}

resource "aws_instance" "example1"{
    ami = "ami-02af70169146bbdd3"
    instance_type = "t2.micro"

    tags{
     Name = "TF-instance"
    }
}