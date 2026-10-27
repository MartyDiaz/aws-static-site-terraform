variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-west-2"
}

variable "bucket_name" {
  description = "Globally unique name for the site bucket"
  type        = string
}

variable "github_repo" {
  description = "Github repo allowed to deploy, in ONWER/REPO format"
  type        = string
}

variable "github_repo_subject" {
  description = "GitHub OIDC subject prefix: OWNER@OWNER_ID/REPO@REPO_ID"
  type        = string
  default     = "MartyDiaz@67561284/aws-static-site-terraform@1422632721"
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket that stores Terraform state"
  type        = string
  default     = "md0001-tfstate"
}