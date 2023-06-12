resource "aws_lb" "Poc_LB" {
  name = var.LB_NAME
  internal = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.PoC_SG.id]
  subnets            = [aws_subnet.Poc_Subnet_a.id,aws_subnet.Poc_Subnet_b.id,aws_subnet.Poc_Subnet_c.id]
}

resource "aws_lb_listener" "Poc_LB_listener" {
  load_balancer_arn = aws_lb.Poc_LB.arn
  port              = var.SG_PORT_HTTP
  protocol          = var.LB_PROTOCOL

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Poc_TG.arn
  }
}

resource "aws_lb_target_group" "Poc_TG" {
  name     = "PoC-Target-Group"
  target_type = "instance"
  port     = var.SG_PORT_HTTP
  protocol = var.LB_PROTOCOL
  vpc_id   = aws_vpc.Demo_webapp_vpc.id
}