resource "aws_vpc" "VPC" {
    cidr_block = "10.0.0.0/16"
    tags = {
    Name = "VPC"
  }
}

resource "aws_internet_gateway" "Igw" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "Igw"
  }
}

resource "aws_route_table" "PublicRtb" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw.id
  }

  tags = {
    Name = "PublicRtb"
  }
}

resource "aws_route_table" "PrivateRtb" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "PrivateRtb"
  }
}

resource "aws_subnet" "subnetPublicA" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-1a"

  tags = {
    Name = "subnetPublicA"
  }
}

resource "aws_subnet" "subnetPublicB" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-1b"

  tags = {
    Name = "subnetPublicB"
  }
}

resource "aws_subnet" "subnetPrivateA" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "us-west-1a"

  tags = {
    Name = "subnetPrivateA"
  }
}

resource "aws_subnet" "subnetPrivateB" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = "10.0.12.0/24"
  availability_zone = "us-west-1b"

  tags = {
    Name = "subnetPrivateB"
  }
}

resource "aws_route_table_association" "associationPublicA" {
  subnet_id      = aws_subnet.subnetPublicA.id
  route_table_id = aws_route_table.PublicRtb.id
}

resource "aws_route_table_association" "associationPublicB" {
  subnet_id      = aws_subnet.subnetPublicB.id
  route_table_id = aws_route_table.PublicRtb.id
}

resource "aws_route_table_association" "associationPrivateA" {
  subnet_id      = aws_subnet.subnetPrivateA.id
  route_table_id = aws_route_table.PrivateRtb.id
}

resource "aws_route_table_association" "associationPrivateB" {
  subnet_id      = aws_subnet.subnetPrivateB.id
  route_table_id = aws_route_table.PrivateRtb.id
}