#---------------------------------------------#
#Public Subnet 1a,1c
#---------------------------------------------#

resource "aws_subnet" "public-subnet-1a" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "192.168.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1a-terraform"
  }
}

resource "aws_subnet" "public-subnet-1c" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1c-terraform"
  }
}

#---------------------------------------------#
#Private Subnet 1a,1c
#---------------------------------------------#

resource "aws_subnet" "private-subnet-1a" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "192.168.2.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1a-terraform"
  }
}

resource "aws_subnet" "private-subnet-1c" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "192.168.3.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1c-terraform"
  }
}

#---------------------------------------------#
#Public Subnet for ALB
#---------------------------------------------#

resource "aws_subnet" "primary-subnet" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "192.168.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "primary-subnet-ALB"
  }
}

resource "aws_subnet" "secondary-subnet" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "secondary-subnet-ALB"
  }
}



