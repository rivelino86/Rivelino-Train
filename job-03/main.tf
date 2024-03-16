variable "servers-list" {
  description = "This variable is used to list the servers with those parameters"

  default = [

    { name : "jenkins",  script : "install_jenkins.sh", port : 8080, size : "t2.micro" , server_ami : "ami-0440d3b780d96b29d",id:1},
    { name : "splunk",   script : "install_splunk.sh",  port : 8000, size : "t2.medium" ,server_ami : "ami-0440d3b780d96b29d" ,id:2},
    { name : "jenkins0", script : "install_jenkins.sh", port : 8080, size : "t2.micro" , server_ami : "ami-0440d3b780d96b29d",id:3},
    { name : "jenkins1", script : "install_jenkins.sh", port : 8080, size : "t2.micro" , server_ami : "ami-0440d3b780d96b29d",id:4},
    { name : "jenkins2", script : "install_jenkins.sh", port : 8080, size : "t2.micro" , server_ami : "ami-0440d3b780d96b29d",id:5},

    { name : "jenkins3", script : "install_jenkins.sh", port : 8080, size : "t2.micro" , server_ami : "ami-0440d3b780d96b29d",id:6},
    { name : "jenkins4", script : "install_jenkins.sh", port : 8080, size : "t2.micro" , server_ami : "ami-0440d3b780d96b29d",id:7},
    { name : "jenkins6", script : "install_jenkins.sh", port : 8080, size : "t2.micro" , server_ami : "ami-0440d3b780d96b29d",id:8},
    { name : "jenkins7", script : "install_jenkins.sh", port : 8080, size : "t2.micro" , server_ami : "ami-0440d3b780d96b29d",id:9},

    { name : "jenkins8", script : "install_jenkins.sh", port : 8080, size : "t2.micro" , server_ami : "ami-0440d3b780d96b29d",id:10},
    { name : "jenkins9", script : "install_jenkins.sh", port : 8080, size : "t2.micro" , server_ami : "ami-0440d3b780d96b29d",id:11},
    { name : "jenkins10",script : "install_jenkins.sh", port : 8080, size : "t2.micro" , server_ami : "ami-0440d3b780d96b29d",id:12}
    
  ]

}

######################// 1er method using for loop approach ###################################""""
# resource "aws_instance" "server" {
    
#     for_each ={for item in var.servers-list:item.id => item }

#     ami = each.value.server_ami
#     instance_type = each.value.size
#     user_data = file(each.value.script)
#     //security_groups = []

#     tags = {
#       Name = "Server-${each.value.name}"
#     }
  
# }

######################// 2e method using index approach ###################################""""
resource "aws_instance" "server" {
    
    count = length(var.servers-list)

    ami = var.servers-list[count.index].server_ami
    instance_type = var.servers-list[count.index].size
    user_data = file(var.servers-list[count.index].script)
    //security_groups = []

    tags = {
      Name = "Server-${var.servers-list[count.index].name}"
    }
  
}

# resource "null_resource" "my_resource" {

#     count = length(var.servers-list)
    
#     # for_each = {
#     #   for element in var.servers-list: element.name => element
#     # }
# #   ${each.value.script} ${each.value.name} ${each.value.port} ${each.value.server_ami}
#   provisioner "local-exec" {
#     command = "echo ${var.servers-list[count.index].name} "
#   }
# }



output "values_contents_first" {
  value = var.servers-list[0]
}

output "server_ami" {
   value = var.servers-list[0].server_ami
}

output "values_contents_second" {
  value = var.servers-list[1]
}