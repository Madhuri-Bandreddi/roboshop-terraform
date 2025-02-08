terraform {
  backend "s3" {
    bucket = "terrafrom-r72"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}