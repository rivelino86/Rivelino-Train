


resource "aws_vpc" "my-aws-vpc" {

  cidr_block = var.vpc_cidr_bloks

  tags = {
    Name : var.vpc_name
    env : "${var.env_prefix}-vpc"
    team : var.team_name
    created_by : var.owner_name
  }

}

resource "aws_subnet" "my_private_subnets" {
  count             = length(var.private_subnet_blocks)      # get the number of subnets blocks you have
  cidr_block        = var.private_subnet_blocks[count.index] # define the cidr block per subnet
  availability_zone = var.availability_zone[count.index]     # Assign the availability zone to each subnet
  vpc_id            = aws_vpc.my-aws-vpc.id                  # Connect your subnets to your VPC

}


resource "aws_subnet" "my_public_subnets" {
  count                   = length(var.public_subnet_blocks)      # get the number of public subnets blocks you have
  cidr_block              = var.public_subnet_blocks[count.index] # define the cidr block per public subnet
  availability_zone       = var.availability_zone[count.index]    # Assign the availability zone to each subnet
  vpc_id                  = aws_vpc.my-aws-vpc.id                 # Connect your subnets to your VPC
  map_public_ip_on_launch = true                                  # Allow my subnet access to internet
}




# resource "aws_route_table" "my_aws-route_table" {
#    vpc_id = aws_vpc.my-aws-vpc.id
#    route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_internet_gateway.my_igw.id
#    }
# }


// I create my gateway here
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my-aws-vpc.id
  tags = {
    Name : "${var.env_prefix}-wdp-IGW"
  }
}

// I use my default route table created when the vpc is created
resource "aws_default_route_table" "my_default_route_table" {
  default_route_table_id = aws_vpc.my-aws-vpc.default_route_table_id
  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.my_igw.id

  }
}



// This statement helps me to request dynamically my current public ip address 
// sometimes my public ip address can change in the future because is not static (vendor)
data "http" "my_ip" {
  url = var.get_my_ipaddress
}

