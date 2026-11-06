
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "shopsphere_vpc" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "ShopSphere-VPC"
    Project = "ShopSphere"
  }
}

# Get two Availability Zones in Mumbai
data "aws_availability_zones" "available" {
  state = "available"
}

# Public Subnet A
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.shopsphere_vpc.id
  cidr_block              = "10.20.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name    = "ShopSphere-Public-A"
    Project = "ShopSphere"
    Tier    = "Public"
  }
}

# Public Subnet B
resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.shopsphere_vpc.id
  cidr_block              = "10.20.2.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name    = "ShopSphere-Public-B"
    Project = "ShopSphere"
    Tier    = "Public"
  }
}

# Private Application Subnet A
resource "aws_subnet" "app_a" {
  vpc_id            = aws_vpc.shopsphere_vpc.id
  cidr_block        = "10.20.11.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name    = "ShopSphere-App-A"
    Project = "ShopSphere"
    Tier    = "Private-App"
  }
}

# Private Application Subnet B
resource "aws_subnet" "app_b" {
  vpc_id            = aws_vpc.shopsphere_vpc.id
  cidr_block        = "10.20.12.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name    = "ShopSphere-App-B"
    Project = "ShopSphere"
    Tier    = "Private-App"
  }
}

# Private Database Subnet A
resource "aws_subnet" "db_a" {
  vpc_id            = aws_vpc.shopsphere_vpc.id
  cidr_block        = "10.20.21.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name    = "ShopSphere-DB-A"
    Project = "ShopSphere"
    Tier    = "Private-DB"
  }
}

# Private Database Subnet B
resource "aws_subnet" "db_b" {
  vpc_id            = aws_vpc.shopsphere_vpc.id
  cidr_block        = "10.20.22.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name    = "ShopSphere-DB-B"
    Project = "ShopSphere"
    Tier    = "Private-DB"
  }
}
resource "aws_internet_gateway" "shopsphere_igw" {
  vpc_id = aws_vpc.shopsphere_vpc.id

  tags = {
    Name    = "ShopSphere-IGW"
    Project = "ShopSphere"
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.shopsphere_vpc.id

  tags = {
    Name    = "ShopSphere-Public-RT"
    Project = "ShopSphere"
  }
}
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.shopsphere_igw.id
}
resource "aws_route_table_association" "public_a_association" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_b_association" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table" "private_app_rt" {
  vpc_id = aws_vpc.shopsphere_vpc.id

  tags = {
    Name    = "ShopSphere-Private-App-RT"
    Project = "ShopSphere"
  }
}
resource "aws_route_table_association" "app_a_association" {
  subnet_id      = aws_subnet.app_a.id
  route_table_id = aws_route_table.private_app_rt.id
}

resource "aws_route_table_association" "app_b_association" {
  subnet_id      = aws_subnet.app_b.id
  route_table_id = aws_route_table.private_app_rt.id
}
resource "aws_route_table" "private_db_rt" {
  vpc_id = aws_vpc.shopsphere_vpc.id

  tags = {
    Name    = "ShopSphere-Private-DB-RT"
    Project = "ShopSphere"
  }
}
resource "aws_route_table_association" "db_a_association" {
  subnet_id      = aws_subnet.db_a.id
  route_table_id = aws_route_table.private_db_rt.id
}

resource "aws_route_table_association" "db_b_association" {
  subnet_id      = aws_subnet.db_b.id
  route_table_id = aws_route_table.private_db_rt.id
}