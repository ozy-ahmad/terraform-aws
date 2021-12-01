// --- networking/main.tf --- //

data "aws_availability_zones" "available" {}

resource "random_integer" "random" {
    min = 1
    max = 20
}

resource "random_shuffle" "az_list" {
    input = data.aws_availability_zones.available.names
    result_count = var.max_subnets
}

resource "aws_vpc" "ozy_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    
    tags = {
        Name = "ozy_vpc-${random_integer.random.id}"
        Owner = "ozy"
        Manage = "terraform"
    }
}
resource "aws_subnet" "ozy_public_subnet" {
    count = var.public_sn_count
    vpc_id = aws_vpc.ozy_vpc.id
    cidr_block = var.public_cidrs[count.index]
    map_public_ip_on_launch = true
    availability_zone = random_shuffle.az_list.result[count.index]
    
    tags = {
        Name = "ozy_public_${count.index + 1}"
    }
}

resource "aws_route_table_association" "ozy_pub-asoc" {
    count = var.public_sn_count
    subnet_id = aws_subnet.ozy_public_subnet.*.id[count.index]
    route_table_id = aws_route_table.ozy_public_rt.id
}

resource "aws_subnet" "ozy_private_subnet" {
    count = var.private_sn_count
    vpc_id = aws_vpc.ozy_vpc.id
    cidr_block = var.private_cidrs[count.index]
    map_public_ip_on_launch = false
    availability_zone = random_shuffle.az_list.result[count.index]
    
    tags = {
        Name = "ozy_private_${count.index + 1}"
    }
}

resource "aws_internet_gateway" "ozy_igw" {
    vpc_id = aws_vpc.ozy_vpc.id

  tags = {
    Name = "ozy_igw"
  }
}
resource "aws_route_table" "ozy_public_rt" {
    vpc_id = aws_vpc.ozy_vpc.id

  tags = {
    Name = "ozy_public_rt"
  }
}

resource "aws_route" "default_route" {
    route_table_id = aws_route_table.ozy_public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ozy_igw.id
}

resource "aws_default_route_table" "ozy_private_rt" {
    default_route_table_id = aws_vpc.ozy_vpc.default_route_table_id
    
    tags = {
    Name = "ozy_private_rt"
  }
}