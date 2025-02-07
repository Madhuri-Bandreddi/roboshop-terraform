data "aws_ami" "centos" {
  owners      = ["973714476881"]
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
}

data "aws_security_group" "allow_all" {
  name = "allow-all"
}

variable "instance_type" {
  default ="t2.micro"
}

resource "aws_instance" "frontend" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]

  tags = {
    Name = "frontend"
  }
}

resource "aws_route53_record" "frontend" {
  zone_id  = "Z06377673P2QZ3HGG0TOY"
  name     = "frontend-dev.rdevopsb72.online"
  type     = "A"
  ttl      = 30
  records = [aws_instance.frontend.private_ip]
}

