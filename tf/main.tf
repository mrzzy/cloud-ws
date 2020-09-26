#
# cloudws
# Terraform Deploy
#

provider "aws" {
  region = "ap-southeast-1"
}

## Remote Terraform State
# S3 Bucket for storing terraform remote state
resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "cloud-ws-tf-remote-state"
  acl    = "private"

  versioning {
    enabled = true
  }
  tags = {
    Name    = "Terraform State"
    Project = "cloud-ws"
  }
}

# Configure terraform to use remote state
terraform {
  backend "s3" {
    bucket = "cloud-ws-tf-remote-state"
    key    = "tfstate/tf.tfstate"
    region = "ap-southeast-1"
  }
}

## Key Pair attached by deployed instances
resource "aws_key_pair" "ssh_key" {
  key_name   = "cloud-ws-ssh-key"
  public_key = var.ssh_public_key
}


## Devcrate instance for development
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_security_group" "devcrate_sg" {
  name        = "devcrate_sg"
  description = "devcrate allow ssh"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Devcrate security group"
  }
}


# Security group required to allow SSH
resource "aws_instance" "devcrate" {
  instance_type = "t3.micro"
  ami = data.aws_ami.ubuntu.id

  tags = {
    Name    = "devcrate instance"
    Project = "cloud-ws"
  }

  vpc_security_group_ids = [aws_security_group.devcrate_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name
  user_data              = <<EOF
  #!env sh
  set -ex
  curl -fsSL https://get.docker.com | sh -
  sudo usermod -aG docker ubuntu
  docker pull ${var.devcrate_container}
  EOF
}

