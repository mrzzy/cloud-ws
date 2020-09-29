#
# cloudws
# Autoscaling module
#

variable "key_pair" {
  type        = string
  description = "Sets the name of the AWS key pair used to access created instances via SSH"
}

variable "name_prefix" {
  type = string
  description = "Prefix to add the name of acreated resources for namespacing"
  default = "autoscaling"
}

variable "instance_type" {
  type = string
  description = "Sets the instance type of the instances in the autoscaling group"
  default = "t3.micro"
}

variable "ami_id" {
  type = string
  description = "Sets the AMI VM image used by created instances"
}

variable "vpc_id" {
  type = string 
  description = "Sets the id of the specific VPC to associate instance networking to"
}

variable "subnet_id" {
  type = string
  description = "Sets the id of the specific subnet to associate instance networking to."
}

variable "exposed_ports" {
  type = list(string)
  description = "List of ports to allow the security group of the created instances"
}

variable "min_scale" {
  type = number
  description = "Sets the minimum number of instances the scaler is allowed to scale to"
  default = 1
}

variable "max_scale" {
  type = number
  description = "Sets the maximum number of instances the scaler is allowed to scale to"
  default = 3
}

variable "user_data" {
  type = string 
  description = "Sets the user data to provide to instances"
}
