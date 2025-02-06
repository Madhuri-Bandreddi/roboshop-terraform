data "aws_ami" "centos" {
  owners      = ["703671922613"]
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
}

variable "instance_type" {
  default = "t2.micro"
}

resource "aws_instance" "frontend" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "frontend"

  }
}
resource "aws_route53_record" "frontend" {
  zone_id = "Z06377673P2QZ3HGG0TOY"
  name    = "frontend.madhari123.shop"
  type    = "A"
  ttl     = 30
  records = [aws_instance.frontend.private_ip]
}
