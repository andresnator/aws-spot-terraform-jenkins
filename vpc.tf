# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name             = var.INSTANCE_NAME
    L1_AREA          = var.L1_AREA
    L5_PRODUCT       = var.L5_PRODUCT
    L6_ENVIRONMENT   = var.L6_ENVIRONMENT
    L7_FUNCTIONALITY = var.L7_FUNCTIONALITY
    L8_TEAM          = var.L8_TEAM
  }
}

# Subnets
resource "aws_subnet" "main-public-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.AVAILABILITY_ZONE

  tags = {
    Name             = var.INSTANCE_NAME
    L1_AREA          = var.L1_AREA
    L5_PRODUCT       = var.L5_PRODUCT
    L6_ENVIRONMENT   = var.L6_ENVIRONMENT
    L7_FUNCTIONALITY = var.L7_FUNCTIONALITY
    L8_TEAM          = var.L8_TEAM
  }
}

resource "aws_subnet" "main-private-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.AVAILABILITY_ZONE

  tags = {
    Name             = var.INSTANCE_NAME
    L1_AREA          = var.L1_AREA
    L5_PRODUCT       = var.L5_PRODUCT
    L6_ENVIRONMENT   = var.L6_ENVIRONMENT
    L7_FUNCTIONALITY = var.L7_FUNCTIONALITY
    L8_TEAM          = var.L8_TEAM
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name             = var.INSTANCE_NAME
    L1_AREA          = var.L1_AREA
    L5_PRODUCT       = var.L5_PRODUCT
    L6_ENVIRONMENT   = var.L6_ENVIRONMENT
    L7_FUNCTIONALITY = var.L7_FUNCTIONALITY
    L8_TEAM          = var.L8_TEAM
  }
}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name             = var.INSTANCE_NAME
    L1_AREA          = var.L1_AREA
    L5_PRODUCT       = var.L5_PRODUCT
    L6_ENVIRONMENT   = var.L6_ENVIRONMENT
    L7_FUNCTIONALITY = var.L7_FUNCTIONALITY
    L8_TEAM          = var.L8_TEAM
  }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.main-public-1.id
  route_table_id = aws_route_table.main-public.id
}