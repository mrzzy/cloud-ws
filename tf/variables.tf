#
# cloudws
# Terraform Deploy
# Variables
#

variable "ssh_public_key" {
  type        = string
  description = "Sets the SSH key pair that can be used to access created instances via SSH"
}

variable "devcrate_container" {
  type        = string
  description = "Sets the container image pulled in the devcrate instance"
  default     = "docker.io/mrzzy/devcrate-cloud:latest"
}

