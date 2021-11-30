// --- networking/main.tf --- //

resource "random_integer" "random" {
    min = 1
    max = 20
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
    count = length(var.public_cidrs)
    vpc_id = aws_vpc.ozy_vpc.id
    cidr_block = var.public_cidrs[count.index]
    map_public_ip_on_launch = true
    availability_zone = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"][count.index]
    
    tags = {
        Name = "ozy_public_${count.index + 1}"
    }
}