variable "aws_region" {
  description = "AWS region on which we will setup the swarm cluster"
  default = "us-east-2"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default = "ami-5c0c3339"
}

variable "instance_type" {
  description = "Instance type"
  default = "t2.micro"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "/Users/jzuniga/Documents/AWS/jenkins1.pub"
}

variable "bootstrap_path" {
  description = "Script to install Docker Engine"
  default = "install-docker.sh"
}
