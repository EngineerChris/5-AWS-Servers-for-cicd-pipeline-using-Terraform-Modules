resource "aws_instance" "jenkins" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  tags = {
    Name = "Jenkins Server"
  }

  user_data = file("${path.module}/jenkins-install-user-data.sh")

  lifecycle {
    create_before_destroy = false
  }
}

output "public_ip" {
  value = aws_instance.jenkins.public_ip
}
