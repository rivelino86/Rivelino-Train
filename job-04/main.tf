terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
  }
}

# Configure the AWS Provider

provider "aws" {
  region = "us-east-1"
}




resource "aws_instance" "web_server" {
  ami           = var.ami
  instance_type = var.size
  user_data     = file(var.script)
  key_name      = aws_key_pair.ec2_key.key_name

  vpc_security_group_ids = [aws_default_security_group.my_sg.id]
  subnet_id              = aws_subnet.my_public_subnets[0].id
  availability_zone      = var.availability_zone[0]

  root_block_device {
    volume_size = var.storage_size
  }

  tags = {
    Name : var.server_name
    Team : var.team_name
    Environment : var.env_prefix
    by : var.owner_name
  }
}


resource "aws_default_security_group" "my_sg" {

  vpc_id = aws_vpc.my-aws-vpc.id

  tags = {
    Name : "${var.sg_name}-sg"
  }

  dynamic "ingress" {
    for_each = var.app_ports
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      cidr_blocks = (ingress.value.port == 22 ? ["${data.http.my_ip.response_body}/32"] : ingress.value.cidr_blocks) //
      protocol    = ingress.value.protocol

    }

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [data.http.my_ip]
}


output "my_ip" {
  value = data.http.my_ip.response_body
}

output "my_ssh_link" {

  value = "ssh -i ${var.key_name}.pem  ${var.default_user}@${aws_instance.web_server.public_ip} "
  
}