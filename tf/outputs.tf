#
# cloudws
# Terraform Deploy
# Outputs
#

output "devcrate_ip" {
  description = "IP of the Devcrate instanc"
  value       = aws_instance.devcrate.public_ip
}
