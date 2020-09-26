#
# cloudws
# Terraform Deploy
#

provider "aws" {
  region = "ap-southeast-1"
}

## Remote Terraform State
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

# Configure terraform to use remote state
terraform {
  backend "s3" {
    # point to bucket
    bucket         = "cloud-ws-tf-remote-state"
    key            = "tfstate/tf.tfstate"
    region         = "ap-southeast-1"

    # optional: dynamodb_table for locking ...
  }
}

