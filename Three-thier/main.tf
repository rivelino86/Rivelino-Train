
resource "aws_instance" "web_server_1" {
  ami           = var.ami
  instance_type = var.size
  user_data     = file(var.script)
  //key_name      = aws_key_pair.ec2_key.key_name

  vpc_security_group_ids = [aws_security_group.srv_sg.id]
  subnet_id              = aws_subnet.private_subnets_az1.id
  availability_zone      = var.availability_zone[0]
  associate_public_ip_address = true
#   root_block_device {
#     volume_size = var.storage_size
#   }

  tags = {

    Name : "my_server_az1"

  }

}

resource "aws_instance" "web_server_2" {
  ami           = var.ami
  instance_type = var.size
  user_data     = file(var.script)
  //key_name      = aws_key_pair.ec2_key.key_name

  vpc_security_group_ids = [aws_security_group.srv_sg.id]
  subnet_id              = aws_subnet.private_subnets_az2.id
  availability_zone      = var.availability_zone[1]

#   root_block_device {
#     volume_size = var.storage_size
#   }

  tags = {

    Name : "my_server_az2"

  }

}

