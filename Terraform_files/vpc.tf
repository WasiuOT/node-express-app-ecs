data "aws_vpc" "vpc" {
  tags = {
    Name = "main-vpc"
  }
}

data "aws_subnet" "subnet1" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = "subnet1"
  }
}

data "aws_subnet" "subnet2" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = "subnet2"
  }
}


data "aws_subnet" "subnet3" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = "subnet3"
  }
}

data "aws_subnet" "subnet4" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = "subnet4"
  }
}

data "aws_security_group" "sg" {
  name   = "allow-http-ssh-postgres-app"
}

