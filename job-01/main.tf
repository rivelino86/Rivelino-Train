
// what do you need to create a default new ec2 instance ?
/*
    1- security group
    2- vpc
    3- volume
    4- ami
    5- instance_type


*/


resource "aws_instance" "web_server" {
  ami           = var.c
  instance_type = var.size
  user_data     = file("install_resume.sh")
  security_groups = [ aws_security_group.sg-server.name ]
  key_name = aws_key_pair.ec2_key.key_name
  tags = {
    name = "my_resume"
  }
   // /home/ec2/aws/
    provisioner "file" {
        source="website.jpg"
        destination = "/home/ec2-user/website.jpg"
    }

    connection {
      type = "ssh"
      user = "ec2-user"
      host = self.public_ip
      private_key = file(local_file.ssh_key.filename) // file.pem
    
    }


}

// This web site need to open the 80 port
// create a security group to open the 80 port
/*


*/

resource "aws_security_group" "sg-server" {

  name        = "my_ssh_http"
  description = "This sg help me to connect my server"

  ingress { // corresponding to inbound into aws console
    description = "open the ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress { // corresponding to inbound into aws console
    description = "open the http"
    from_port   = 80
    to_port     = 80
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
    Name ="dev_security_grou"
  }
}

resource "aws_security_group" "sg-server" {

  name        = "my_ping_secu"
  description = "This sg help me to connect my server"

  ingress { // corresponding to inbound into aws console
    description = "open the icmp"
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress { // corresponding to inbound into aws console
    description = "open the http"
    from_port   = 80
    to_port     = 80
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
    Name ="dev_security_grou"
  }
}