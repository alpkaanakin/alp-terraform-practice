resource "aws_instance" "demo_public"{
    instance_type = var.ec2_type
    ami = var.ec2_ami
    count = length(var.public_subnets)
    subnet_id = aws_subnet.public[count.index].id

    depends_on = [
        aws_subnet.public,
        aws_subnet.private
    ]

    vpc_security_group_ids = [aws_security_group.only_ssh_vpc.id]

    



        tags = {
        Name: "${var.name}-ec2"
    }
}

resource "aws_instance" "demo_private"{
    instance_type = var.ec2_type
    ami = var.ec2_ami
    count = length(var.public_subnets)
    subnet_id = aws_subnet.private[count.index].id

    depends_on = [
        aws_subnet.public,
        aws_subnet.private
    ]

    vpc_security_group_ids = [aws_security_group.only_ssh_vpc.id]

    



        tags = {
        Name: "${var.name}-ec2"
    }
}





resource "aws_security_group" "only_ssh_vpc" {
    vpc_id = "${aws_vpc.main.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
    }
    tags = merge(
        {Name = var.name},
        {"sec" = "vpc-allowed"}
    )
    
}