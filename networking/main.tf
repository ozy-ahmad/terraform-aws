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