provider "aws" { 
  access_key = "AKIAJIVLONMUTPTPDVBQ"
  secret_key = "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"
  region     = "us-east-2"
}

resource "aws_security_group" "ssh_and_http" {
  name = "allow_ssh_and_http"
  description = "Allow SSH and HTTP traffic"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins_master" {
    ami = "ami-5c0c3339"
    instance_type = "t2.micro"
    key_name = "jenkins1"
    security_groups = ["${aws_security_group.ssh_and_http.name}"]

    tags {
        Name = "jenkins_master"
        role = "jenkins_master"
    }
}

resource "aws_eip" "jenkins_master" {
    instance = "${aws_instance.jenkins_master.id}"
    vpc = true
}
