provider "aws"{
    region = "us-east-1"
}

variable "ami_id"{
    description = "please provide the ami id for the OS you want"
}
variable "instance_type_id"{
    description = "please provide the type of instances you need for your appliactions to run"
}

resource "aws_instance" "example"{
    ami = var.ami_id
    instance_type = var.instance_type_id
}