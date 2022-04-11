

resource "aws_instance" "EC2Apache" {
    ami = "ami-0892d3c7ee96c0bf7"
    instance_type = "t3.micro"
    security_groups = [var.EC2PubSecGP]
    subnet_id = var.subnetPublicA
    tags = {
    Name = "EC2Apache"
   }
}

resource "aws_instance" "EC2Back" {
    ami = "ami-0892d3c7ee96c0bf7"
    instance_type = "t3.micro"
    security_groups = [var.EC2PrivSecGP]
    subnet_id = var.subnetPrivateA
    tags = {
    Name = "EC2Back"
  }
}

resource "aws_eip" "eip" {
  instance = aws_instance.EC2Apache.id
}
