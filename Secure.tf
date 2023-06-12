resource "aws_security_group" "PoC_SG" {
  name = var.SG_NAME
  vpc_id      = aws_vpc.Demo_webapp_vpc.id

  ingress {
    description      = var.SG_DESCRIPTION
    from_port        = var.SG_PORT_HTTP
    to_port          = var.SG_PORT_HTTP
    protocol         = var.SG_PROTOCOL
    cidr_blocks      = var.SG_CIDR
  }

  ingress {
    description      = "Allow http from everywhere"
    from_port        = var.SG_PORT_SSH
    to_port          = var.SG_PORT_SSH
    protocol         = var.SG_PROTOCOL
    cidr_blocks      = var.SG_CIDR
  }

  egress {
    description      = "Allow outgoing traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.SG_NAME
  }
}