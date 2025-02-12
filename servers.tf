resource "aws_instance" "instance" {
  for_each               = var.components
  ami                    = data.aws_ami.centos.image_id
  instance_type          = each,value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.default VPC security group.id]

  tags = {
    Name = each.value["name"]
  }
}

resource "null_resource" "provisioner" {

  depends_on = [aws_instance.instance, aws_route53_record.records]
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "root"
      password = "DevOps321"
      host     = aws_instance.instance[each.value["name"]].pravate_ip
    }

    inline = [
      "rm -rf roboshop-shell",
      "git clone https://github.com/Madhuri-Bandreddi/roboshop-terraform.git",
      "cd roboshop-shell",
      "sudo bash ${each.value["name"]}.sh ${lookup(each.value,"password" , "null")}"
    ]
  }
}

resource "aws_route53_record" "records" {
  for_each               = var.components
  zone_id = "Z03986262CQPCHNJNZM9L"
  name     = "${each.value["name"]}-dev.rdevopsb72.online"
  type     = "A"
  ttl      = 30
  records  = [aws_instance.instance[each.value["name"]]private_ip]
}