variable "ACCESS_KEY" {}
variable "SECRET_KEY" {}

variable "AMI" {
  type = map(string)
  default = {
    eu-west-1 = "ami-0bb3fad3c0286ebd5"
    eu-west-2 = "ami-0a669382ea0feb73a"
  }
}

variable "REGION" {
  default = "eu-west-1"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "KEY_NAME" {
  default = "TU_Dublin"
}

variable "TAGS" {
  default = "Demo_webapp_vpc"
}
variable "VM_NAME" {
  default = "POC_VM"
}

##### Declare thre subents tags ######
variable "Subnet_A" {
  default = "Poc_Subnet_a"
}
variable "Subnet_B" {
  default = "Poc_Subnet_b"
}
variable "Subnet_C" {
  default = "Poc_Subnet_C"
}

###Declare Internate Gateway#####

variable "Gateway" {
  default = "Poc_GW"
}

##Declare Security group variables #
variable "SG_NAME" {
  default = "PoCSecurityGroup"
}

variable "SG_DESCRIPTION" {
  default = "Allow SSH and HTTP"
}

variable "SG_PORT_SSH" {
  default = "22"
}

variable "SG_PORT_HTTP" {
  default = "80"
}

variable "SG_PROTOCOL" {
  default = "tcp"
}
variable "LB_PROTOCOL" {
  default = "HTTP"
}

variable "SG_CIDR" {
  default = ["0.0.0.0/0"]
}

#######Load Balancer###

variable "LB_NAME" {
  default = "DemoLB"

}
variable "COUNT" {

  default = "2"
}