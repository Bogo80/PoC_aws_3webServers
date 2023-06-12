#Crete 3 Subenets in 3 availability zone

resource "aws_subnet" "Poc_Subnet_a" {
  vpc_id     = aws_vpc.Demo_webapp_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = var.Subnet_A
	}
}

resource "aws_subnet" "Poc_Subnet_b" {
  vpc_id     = aws_vpc.Demo_webapp_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-1b"
  tags = {
    Name = var.Subnet_B
	}
}

resource "aws_subnet" "Poc_Subnet_c" {
  vpc_id     = aws_vpc.Demo_webapp_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-1c"
  tags = {
    Name = var.Subnet_C
	}
}
#Create an internet gateway

resource "aws_internet_gateway" "Poc_GW" {
  vpc_id = aws_vpc.Demo_webapp_vpc.id
  tags = {
    Name = var.Gateway
  }
}

##Create a Routing table###

resource "aws_route_table" "PoC_route" {
  vpc_id = aws_vpc.Demo_webapp_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Poc_GW.id
  }
  tags = {
    Name = "PoC_route"
  }
}

#### 
resource "aws_route_table_association" "Sub_a" {
  subnet_id      = aws_subnet.Poc_Subnet_a.id
  route_table_id = aws_route_table.PoC_route.id
}

resource "aws_route_table_association" "Sub_b" {
  subnet_id      = aws_subnet.Poc_Subnet_b.id
  route_table_id = aws_route_table.PoC_route.id
}

resource "aws_route_table_association" "Sub_c" {
  subnet_id      = aws_subnet.Poc_Subnet_c.id
  route_table_id = aws_route_table.PoC_route.id
}
