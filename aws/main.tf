provider "aws"{
    region =  "us-east-1"
}

resource "aws_instance" "example1"{
    ami = "ami-048ccabfe31ce0d7e"
    instance_type = "t2.micro"

    tags = {
     Name = "TF-instance"
    }
}
