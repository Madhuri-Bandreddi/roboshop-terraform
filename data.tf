data "aws_ami" "centos" {
  owners      = ["703671922613"]
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
}

data "aws_security_group" "allow_all1" {
  name = "default VPC security group"
}