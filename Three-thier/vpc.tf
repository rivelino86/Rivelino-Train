resource "aws_vpc" "my-aws-vpc" {

  cidr_block = var.vpc_cidr_bloks
  enable_dns_hostnames = true
  enable_dns_support = true


  tags = {
    Name : "Devops-Train"
    env : "Devops-Train-vpc"

  }

}



// create internet gateway here
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my-aws-vpc.id
  tags = {
    Name : "DevOps-IGW"
  }
}

// public route table
resource "aws_route_table" "public-route_table" {
   vpc_id = aws_vpc.my-aws-vpc.id
   route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
   }
}

// associate my public subnet to route table
resource "aws_route_table_association" "ass_sb_pub_az1" {
    subnet_id = aws_subnet.public_subnets_az1.id
    route_table_id = aws_route_table.public-route_table.id
    
}
// associate my public subnet to route table
resource "aws_route_table_association" "ass_sb_pub_az2" {
    subnet_id = aws_subnet.public_subnets_az2.id
    route_table_id = aws_route_table.public-route_table.id
    
}


############################# FOR AZ 1 #################################################

resource "aws_eip" "eip_1" {
    depends_on = [ aws_internet_gateway.my_igw ]
   
}

// One Public subnet
resource "aws_subnet" "public_subnets_az1" {
    # get the number of public subnets blocks you have
  cidr_block              = var.public_subnet_blocks[0] # define the cidr block per public subnet
  availability_zone       = var.availability_zone[0]    # Assign the availability zone to each subnet
  vpc_id                  = aws_vpc.my-aws-vpc.id                 # Connect your subnets to your VPC
  map_public_ip_on_launch = true                                  # Allow my subnet access to internet
}


// One Private subnet
resource "aws_subnet" "private_subnets_az1" {
  cidr_block        = var.private_subnet_blocks[0] # define the cidr block per subnet
  availability_zone = var.availability_zone[0]     # Assign the availability zone to each subnet
  vpc_id            = aws_vpc.my-aws-vpc.id                  # Connect your subnets to your VPC

}

// Public nat Gateway for AZ1
resource "aws_nat_gateway" "nat_gateway-pub-az1" {

  subnet_id = aws_subnet.public_subnets_az1.id

  allocation_id = aws_eip.eip_1.id

  depends_on = [ aws_internet_gateway.my_igw ]

}


// private route table
resource "aws_route_table" "route_table_az1" {
   vpc_id = aws_vpc.my-aws-vpc.id
   route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gateway-pub-az1.id
   }
}

// associate my private subnet to route table
resource "aws_route_table_association" "priv_rt_az1" {
    subnet_id = aws_subnet.private_subnets_az1.id
    route_table_id = aws_route_table.route_table_az1.id
    
}


############################# FOR AZ 2 #################################################

resource "aws_eip" "eip_2" {
    depends_on = [ aws_internet_gateway.my_igw ]
   

}


// One Public subnet
resource "aws_subnet" "public_subnets_az2" {
    # get the number of public subnets blocks you have
  cidr_block              = var.public_subnet_blocks[1] # define the cidr block per public subnet
  availability_zone       = var.availability_zone[1]    # Assign the availability zone to each subnet
  vpc_id                  = aws_vpc.my-aws-vpc.id                 # Connect your subnets to your VPC
  map_public_ip_on_launch = true                                  # Allow my subnet access to internet
}


// One Private subnet
resource "aws_subnet" "private_subnets_az2" {
  cidr_block        = var.private_subnet_blocks[1] # define the cidr block per subnet
  availability_zone = var.availability_zone[1]     # Assign the availability zone to each subnet
  vpc_id            = aws_vpc.my-aws-vpc.id                  # Connect your subnets to your VPC

}

// Public nat Gateway
resource "aws_nat_gateway" "nat_gateway-pub-az2" {

  subnet_id = aws_subnet.public_subnets_az2.id

  allocation_id = aws_eip.eip_2.id

  depends_on = [ aws_internet_gateway.my_igw ]

}


// private route table
resource "aws_route_table" "route_table_az2" {
   vpc_id = aws_vpc.my-aws-vpc.id
   route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gateway-pub-az2.id
   }
}

// associate my private subnet to route table
resource "aws_route_table_association" "priv_rt_az2" {
    subnet_id = aws_subnet.private_subnets_az2.id
    route_table_id = aws_route_table.route_table_az2.id
    
}


