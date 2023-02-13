resource "aws_vpc" "imported_vpc" {
  cidr_block =  "10.0.0.0/16"
  tags = {
    Name = "my-import-vpc"
  }
}

resource "aws_instance" "imported-EC2"{

ami = "ami-06c39ed6b42908a36"
instance_type = "t2.micro"
subnet_id = aws_subnet.public-subnet-1a.id
key_name = "EC2-Hack"



}


resource "aws_subnet" "public-subnet-1a" {
  vpc_id = aws_vpc.imported_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-central-1a"

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

