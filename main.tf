provider "aws" {
    access_key  = "${var.access_key}"
    secret_key  = "${var.secret_key}"
    region      = "${var.region}"
}
data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}
