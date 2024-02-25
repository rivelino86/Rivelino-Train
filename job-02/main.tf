

resource "aws_instance" "server" {
    ami = var.ami
    instance_type = var.size
    security_groups = [  aws_security_group.splunk_sg.name ]
    user_data = file("install_splunk.sh")

   tags={
     Name: "splunk_server"
   } 

}

resource "null_resource" "my_resource" {
   
   provisioner "local-exec" {
     command = "bash testing_with_args.sh ${aws_instance.server.public_ip}:${var.port}"
   }
}
