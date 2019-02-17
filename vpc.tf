
# Define a vpc
resource "aws_vpc" "MomentonVPC" {
  cidr_block                = "10.0.0.0/16" 
  tags {
    Name = "MomentonVPC"
  }
}

# Internet gateway for the public subnet
  resource "aws_internet_gateway" "demoIG" {
    vpc_id = "${aws_vpc.MomentonVPC.id}"
    tags {
      Name = "ecsDemoIG"
    }
  }
  
# Public subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id = "${aws_vpc.MomentonVPC.id}"
  cidr_block = "10.0.101.0/24"
  availability_zone = "us-west-1a"
  tags {
    Name = "public_subnet_1"
  }
}

# Public subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id = "${aws_vpc.MomentonVPC.id}"
  cidr_block = "10.0.102.0/24"
  availability_zone = "us-west-1c"
  tags {
    Name = "public_subnet_2"
  }
}

# Public subnet 3
resource "aws_subnet" "public_subnet_3" {
  vpc_id = "${aws_vpc.MomentonVPC.id}"
  cidr_block = "10.0.103.0/24"
  availability_zone = "us-west-1c"
  tags {
    Name = "public_subnet_3"
  }
}

# Private subnet 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id = "${aws_vpc.MomentonVPC.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-1a"
  tags {
    Name = "private_subnet_1"
  }
}

# Private subnet 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id = "${aws_vpc.MomentonVPC.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-1c"
  tags {
    Name = "private_subnet_2"
  }
}

# Private subnet 3
resource "aws_subnet" "private_subnet_3" {
  vpc_id = "${aws_vpc.MomentonVPC.id}"
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-1c"
  tags {
    Name = "private_subnet_3"
  }
}

# Routing table for public subnet
  resource "aws_route_table" "public_subnet_routing_table" {
    vpc_id = "${aws_vpc.MomentonVPC.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.demoIG.id}"
    }
    tags {
      Name = "public_subnet_routing_table"
    }
  }

# Associate the routing table to public subnet
  resource "aws_route_table_association" "demoPubSN0-0RTAssn" {
    subnet_id = "${aws_subnet.public_subnet_1.id}"
    subnet_id = "${aws_subnet.public_subnet_2.id}"
    subnet_id = "${aws_subnet.public_subnet_3.id}"
    route_table_id = "${aws_route_table.public_subnet_routing_table.id}"
  }
  
# ECS Instance Security group

  resource "aws_security_group" "test_public_sg" {
      name = "test_public_sg"
      description = "Test public access security group"
      vpc_id = "${aws_vpc.MomentonVPC.id}"

     ingress {
         from_port = 22
         to_port = 22
         protocol = "tcp"
         cidr_blocks = [
            "0.0.0.0/0"]
     }

     ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [
            "0.0.0.0/0"]
     }

     ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = [
            "0.0.0.0/0"]
      }

     ingress {
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = [
           "0.0.0.0/0",
           "0.0.0.0/0"]
      }

      egress {
          # allow all traffic to private SN
          from_port = "0"
          to_port = "0"
          protocol = "-1"
          cidr_blocks = [
              "0.0.0.0/0"]
      }

      tags {
         Name = "test_public_sg"
       }
  }