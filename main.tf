
#Create a VPC for teh enviroment 

resource "aws_vpc" "Demo_webapp_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.TAGS 
  }
}

resource "aws_launch_template" "my_launch_template" {

  name = "my_launch_template"
  image_id = "ami-0d2f9b5f04091bdb7"
  instance_type = var.INSTANCE_TYPE
  key_name = "TU_Dublin"
  tags = {
      Name = "test"
    }
  
  user_data = filebase64("${path.module}/server.sh")
  
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 8
      volume_type = "gp2"
    }
  
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.PoC_SG.id]
  }
  
}