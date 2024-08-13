Provider "aws" {
    region = "us-east-1"
}

resource "aws_key_pair" "testing"{
    keyname = "testing"
    public_key = file("/home/test/.ssh/PrivateStorage.pub")
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "Project VPC"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tag = {
        Name = "Public-subent-terraform"
    }
}

resource "aws_subnet" "prvite_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1a"
    tag = {
        Name = "Prvite-subenet-terraform"
    }
}

resource "aws_internet_gateway" "gw_terraform" {
    vpc_id = aws_vpc.main.id

    tag = {
        Name = "Project for terraform"
    }   
}

resource "aws_route_table" "tf_routing" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw_terraform.id
    }
    tags = {
        Name = "routing table for terraform"
    }
}

resource "aws_route_table_association" "public_subnet_asso" {
    subent_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.tf_routing.id
}

resource "aws_security_group" "webapp_server" {
    name =  "web-server-app"
    description = "Allow Http to web server"
    vpc_id = aws_vpc.main.id

    ingress{
        description = "HTTP ingress"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_block = ["0.0.0.0/0"]
    }

    ingress{
        description = "SSH ingress"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_block = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0 
        to_port = 0
        protocol = "-1"
        cidr_block = ["0.0.0.0/0"] 
    }
}

resource "aws_instance" "webapp_server" {
    ami = "ami-0261755bbcb8c4a84"
    instance_type = "t2.micro"
    key_name = aws_key_pair.testing.keyname
    vpc_security_group_ids = [aws_security_group.webapp_server.id]
    subenet_id = aws_subnet.public_subnet.id

    connection {
      type = "ssh"
      user =  "ubuntu"
      private_key = file("./id_rsa")
      host = self.public_ip
    }
    provisioner "file" {
      source = "app.py"
      destination = "/home/ubuntu/app.py"
    }

    provisioner "remote-exec" {
        inline = [ 
            "echo 'Hello from remote instances'",
            "sudo apt update -y",
            "sudo apt-get install -y python3-pip",
            "cd /home/ubuntu",
            "sudo pip3 install flask",
            "sudo python3 app.py &"
         ]
    }
}