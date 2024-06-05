resource "aws_instance" "sonarqube" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  tags = {
    Name = "SonarQube Server"
  }

  user_data = file("${path.module}/user_data.sh")

  lifecycle {
    create_before_destroy = true
  }
}

output "public_ip" {
  value = aws_instance.sonarqube.public_ip
}
