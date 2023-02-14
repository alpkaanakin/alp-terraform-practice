variable "base-ami" {
    type = string
    default = "ami-06c39ed6b42908a36"
}

variable "base-ec2-type" {
    type = string
    default = "t2.micro"
}

variable "base-keyName" {
    type = string
    default = "EC2-Hack"
}


variable "vpc-cidr" {
    type = string
    default = "10.0.0.0/16"
}


variable "public-subnet-1a-cidr" {
    type = string
    default = "10.0.0.0/24"
}

variable "public-subnet-1a-az" {
    type = string
    default = "eu-central-1a"
}



