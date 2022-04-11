resource "aws_vpc" "esantosVPC" {
    cidr_block = "10.0.0.0/16"
    tags = {
    Name = "esantosVPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.esantosVPC.id
  tags = {
    Name = "esantosIgw"
  }
}

resource "aws_route_table" "esantosPublicRtb" {
  vpc_id = aws_vpc.esantosVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "esantosPublicRtb"
  }
}

resource "aws_route_table" "esantosPrivateRtb" {
  vpc_id = aws_vpc.esantosVPC.id

  tags = {
    Name = "esantosPrivateRtb"
  }
}

resource "aws_subnet" "subnetPublicA" {
  vpc_id     = aws_vpc.esantosVPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "subnetPublicA"
  }
}

resource "aws_subnet" "subnetPublicB" {
  vpc_id     = aws_vpc.esantosVPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "subnetPublicB"
  }
}

resource "aws_subnet" "subnetPrivateA" {
  vpc_id     = aws_vpc.esantosVPC.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "subnetPrivateA"
  }
}

resource "aws_subnet" "subnetPrivateB" {
  vpc_id     = aws_vpc.esantosVPC.id
  cidr_block = "10.0.12.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "subnetPrivateB"
  }
}

resource "aws_route_table_association" "associationPublicA" {
  subnet_id      = aws_subnet.subnetPublicA.id
  route_table_id = aws_route_table.esantosPublicRtb.id
}

resource "aws_route_table_association" "associationPublicB" {
  subnet_id      = aws_subnet.subnetPublicB.id
  route_table_id = aws_route_table.esantosPublicRtb.id
}

resource "aws_route_table_association" "associationPrivateA" {
  subnet_id      = aws_subnet.subnetPrivateA.id
  route_table_id = aws_route_table.esantosPrivateRtb.id
}

resource "aws_route_table_association" "associationPrivateB" {
  subnet_id      = aws_subnet.subnetPrivateB.id
  route_table_id = aws_route_table.esantosPrivateRtb.id
}