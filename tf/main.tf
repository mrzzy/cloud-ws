#
# cloudws
# Terraform Deploy
#

provider "aws" {
  region = "ap-southeast-1"
}


# S3 Bucket for storing terraform remote state
resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "cloud-ws-tf-remote-state"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name    = "Terraform State"
    Project = "cloud-ws"
  }
}
