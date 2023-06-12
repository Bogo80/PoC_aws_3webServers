# PoC_aws_3webServers
# PoC_3aws_web
# PoC -deploy 3 webservers in AWS using Terraform 

This repository contains Terraform files to set up a basic infrastructure for a high available web application.


<img width="410" alt="image" src="https://github.com/Bogo80/PoC_aws_3webServers/assets/133137279/51083a9d-e4ea-4a9f-afb1-93bfe9595854">

# main.tf
The main.tf file sets up the infrastructure for a web application. It creates a Virtual Private Cloud (VPC) using the specified CIDR block, which serves as an isolated network for the application. Additionally, it defines a launch template for EC2 instances.

The launch template specifies the instance type, key pair for SSH access, and a user data script that will be executed when the instances are launched. It also configures block device mappings for the instances, specifying the volume size and type.

Furthermore, the launch template sets up the network interfaces for the instances. It associates a public IP address with each instance and assigns a security group to control inbound and outbound traffic.

Overall, the main.tf file provisions the necessary infrastructure resources for running a web application in a secure and isolated environment.

# Autoscaling Group
The # AScaling.tf file defines the configuration for an Autoscaling Group, which automatically adjusts the number of instances based on demand.

The AScaling.tf file sets up an autoscaling group in AWS. It defines the group's size limits, health checks, and desired capacity. It also configures scaling policies for adding or removing instances based on CPU utilization. CloudWatch alarms are used to trigger the scaling policies.

# Loadbalan.tf
The Loadbalan.tf file contains Terraform resources for setting up a load balancer to distribute traffic to the instances in the Autoscaling Group.

The Loadbalan.tf file defines an application load balancer in AWS. It specifies the load balancer's name, type, security groups, and subnets. It also configures a listener that forwards traffic to a target group. The target group is associated with instances and determines how the load balancer distributes traffic.

# network.tf
The network.tf file sets up the networking components for the infrastructure.

Three subnets (aws_subnet) are created in different availability zones, each associated with the VPC and assigned a specific CIDR block and availability zone.
An internet gateway (aws_internet_gateway) is created and associated with the VPC.
A routing table (aws_route_table) is created and configured with a default route that directs traffic to the internet gateway.
The subnets are associated with the routing table using the aws_route_table_association resource.
Overall, these resources establish the necessary network infrastructure, including subnets, an internet gateway, and a routing table, for the deployment.

# providers.tf
The providers.tf file specifies the provider configuration for the AWS provider.

The aws provider is declared with the provider block.
The access key, secret key, and region for the AWS provider are set using the values from the variables var.ACCESS_KEY, var.SECRET_KEY, and var.REGION, respectively.
This configuration allows Terraform to authenticate and connect to the AWS API using the provided access and secret keys, and perform operations in the specified region.

# secure.tf
The secure.tf file creates an AWS security group (aws_security_group) associated with the VPC. The security group allows inbound HTTP and SSH traffic from specified CIDR blocks, allows all outbound traffic, and is tagged with a specific name.

Overall, this configuration ensures controlled access to the infrastructure by permitting specific inbound traffic while allowing unrestricted outbound communication.

# server.sh
The server.sh script updates the system packages, installs Apache web server, sets up a basic HTML page, and starts Apache as a service.
# vars.tf 
The vars.tf file defines variables for AWS access and secret keys, AMI IDs for different regions, instance type, key name, tags, subnet names, gateway name, security group configurations (name, description, ports, protocol), load balancer name, and count. These variables are used throughout the Terraform configuration to provide flexibility and customization options.
