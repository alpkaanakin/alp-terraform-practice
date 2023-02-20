resource "aws_vpc" "main" {
  cidr_block = var.cidr

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.vpc_tags,
  )
}

################################################################################
# subnets
################################################################################

resource "aws_subnet" "public" {
  count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true


  tags = {
    Name = "Main"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  availability_zone       = element(var.availability_zones, count.index)

  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnets[count.index]

  tags = {
    Name = "Main"
  }
}

################################################################################
# Internet Gateway
################################################################################


resource "aws_internet_gateway" "public_gw" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.igw_tags,
  )
}


################################################################################
# public routes 
################################################################################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_gw.id
  }

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.igw_tags,
  )

}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

################################################################################
# security group
################################################################################


resource "aws_security_group" "default" {
  name        = "my-default-sg"
  description = "Default SG to alllow traffic from the VPC"
  vpc_id      = aws_vpc.main.id
  depends_on = [
    aws_vpc.main
  ]

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

}