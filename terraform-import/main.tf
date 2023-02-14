resource "aws_vpc" "imported_vpc" {
  cidr_block =  var.vpc-cidr
  tags = {
    Name = "my-import-vpc"
  }
}

resource "aws_instance" "imported-EC2"{

ami = var.base-ami
instance_type = var.base-ec2-type
subnet_id = aws_subnet.public-subnet-1a.id
key_name = var.base-keyName
vpc_security_group_ids = ["sg-01ab34d6f8f29ecc1"]



}


resource "aws_subnet" "public-subnet-1a" {
  vpc_id = aws_vpc.imported_vpc.id
  cidr_block = var.public-subnet-1a-cidr
  availability_zone = var.public-subnet-1a-az

    tags = {
    Name = "public-subnet-a1"
  }

}

resource "aws_route_table" "routeTable" {
  vpc_id = aws_vpc.imported_vpc.id

    tags = {
    Name = "public-route-table"
  }

}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet-1a.id
  route_table_id = aws_route_table.routeTable.id
}

