

# I reserve this file for the constants I'm going to use in my project.

env_prefix = "dev"

owner_name = "Kossi"

team_name = "wdp"

vpc_name = "utc-app1"

sg_name = "webserver"

vpc_cidr_bloks = "172.120.0.0/16"

route_cidr = "0.0.0.0/0"

ami = "ami-06a0cd9728546d178"

size = "t2.micro"

storage_size = 20 

key_name = "utc-key"

server_name = "utc-dev-inst"

script = "install.sh"

default_user = "ec2-user"

private_subnet_blocks = ["172.120.1.0/24", "172.120.2.0/24"]

public_subnet_blocks = ["172.120.3.0/24", "172.120.4.0/24"]

availability_zone = ["us-east-1a", "us-east-1b"]

get_my_ipaddress = "https://api.ipify.org?format=text"

app_ports = [
                { port : 22,  cidr_blocks : ["myIP"], protocol : "tcp" , description : "allow only my ipaddress to access my server via ssh protocol" }, 
                { port : 80,  cidr_blocks : ["0.0.0.0/0"], protocol : "tcp" , description : "open the apache port to my server" }, 
                { port : 8080,cidr_blocks : ["0.0.0.0/0"], protocol : "tcp" , description : "open the port of my webserver"}
            ]
