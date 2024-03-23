resource "aws_security_group" "lb_sg" {

  vpc_id = aws_vpc.my-aws-vpc.id

  tags = {
    Name : "my-sg-lb"
  }

  ingress{
  
      description = "default port of my load balancer"
      from_port   = 80
      to_port     = 80
      cidr_blocks =  ["0.0.0.0/0"]
      protocol    =  "tcp"

  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}


resource "aws_security_group" "srv_sg" {

  vpc_id = aws_vpc.my-aws-vpc.id

  tags = {
    Name : "my-sg-server"
  }

  ingress{
  
      description = "default port of my load balancer"
      from_port   = 80
      to_port     = 80
      security_groups = [aws_security_group.lb_sg.id]
      protocol    =  "tcp"

  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

