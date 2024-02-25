resource "aws_security_group" "ssh_sg" {

  name        = "my_ssh"
  description = "This sg help me to connect my server via ssh"

  ingress { // corresponding to inbound into aws console
    description = "open the ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }


  egress { // corresponding to outbound into aws console
    description = "go to any ip address"
    from_port   = 0
    to_port     = 0
    protocol    = -1 // corresponding to all traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name ="dev_security_group"
  }
}

resource "aws_security_group" "splunk_sg" {
  
  name        = "my_splunk_port"
  description = "This sg help me to connect my server via ssh"

  
  ingress { // corresponding to inbound into aws console
    description = "open the web application port "
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress { // corresponding to inbound into aws console
    description = "open the port of my splunk server"
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress { // corresponding to outbound into aws console
    description = "go to any ip address"
    from_port   = 0
    to_port     = 0
    protocol    = -1 // corresponding to all traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

}


