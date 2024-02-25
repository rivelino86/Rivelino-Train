

resource "aws_instance" "server" {
  
  count           = (var.kind_of_server != "1" && var.kind_of_server != "2") ? 0 : 1
  ami             = var.ami
  instance_type   = var.size
  
  security_groups = [aws_security_group.my_sg[count.index].name, aws_security_group.ssh_sg[count.index].name]
  user_data       = file("scripts/${var.kind_of_server == "1" ? "install_jenkins.sh" : "install_splunk.sh"}")

  tags = {
    Name : "${var.kind_of_server == "1" ? "jenkins" : "splunk"}_server"
  }

}

resource "null_resource" "my_resource" {
  count = (var.kind_of_server != "1" && var.kind_of_server != "2") ? 0 : 1
  triggers = {
    tg = var.kind_of_server
  }
  provisioner "local-exec" {
    command = "bash scripts/testing_with_args.sh ${aws_instance.server[count.index].public_ip}:${var.kind_of_server == "1" ? 8080 : 8000}"
  }
}


output "my_link" {
 
  value = (var.kind_of_server != "1" && var.kind_of_server != "2") ? "Server not find !!!" : "${aws_instance.server[0].public_ip}:${var.kind_of_server == "1" ? 8080 : 8000}"
}