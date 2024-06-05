provider "aws" {
  region = var.aws_region
}

# VPC - Data source to get the default VPC
data "aws_vpc" "cicd_vpc" {
  default = true
  }

# Subnet
resource "aws_subnet" "cicd_subnet" {
  vpc_id     = data.aws_vpc.cicd_vpc.id
  tags = {
    Name = "cicd_subnet"
  }
}

# Security Groups
resource "aws_security_group" "jenkins" {
  vpc_id = data.aws_vpc.cicd_vpc.id
  name   = "jenkins_sg"
  description = "Security group for Jenkins server"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define security groups for Maven, SonarQube, Gradle, and Nexus similarly

#MAVEN_SG
resource "aws_security_group" "maven" {
  vpc_id = data.aws_vpc.cicd_vpc.id
  name   = "maven_sg"
  description = "Security group for Maven server"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#SONARQUBE_SG

resource "aws_security_group" "sonarqube" {
  vpc_id = data.aws_vpc.cicd_vpc.id
  name   = "sonarqube_sg"
  description = "Security group for SonarQube server"

 # Define SonarQube specific ingress and egress rules

   ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#GRADLE_SG
resource "aws_security_group" "gradle" {
  vpc_id = data.aws_vpc.cicd_vpc.id
  name   = "gradle_sg"
  description = "Security group for Gradle server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# NEXUS SG
resource "aws_security_group" "nexus" {
  vpc_id = data.aws_vpc.this.id
  name   = "nexus_sg"
  description = "Security group for Nexus server"

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# CALLING THE MODULES

module "jenkins" {
  source             = "./modules/jenkins"
  instance_type      = var.jenkins_instance_type
  ami                = var.jenkins_ami
  key_name           = var.key_name
  subnet_id          = aws_subnet.cicd_vpc.id
  security_group_ids = [aws_security_group.jenkins.id]
}

module "maven" {
  source             = "./modules/maven"
  instance_type      = var.maven_instance_type
  ami                = var.maven_ami
  key_name           = var.key_name
  subnet_id          = aws_subnet.cicd_vpc.id
  security_group_ids = [aws_security_group.maven.id]
}

module "sonarqube" {
  source             = "./modules/sonarqube"
  instance_type      = var.sonarqube_instance_type
  ami                = var.sonarqube_ami
  key_name           = var.key_name
  subnet_id          = aws_subnet.cicd_vpc.id
  security_group_ids = [aws_security_group.sonarqube.id]
}

module "gradle" {
  source             = "./modules/gradle"
  instance_type      = var.gradle_instance_type
  ami                = var.gradle_ami
  key_name           = var.key_name
  subnet_id          = aws_subnet.cicd_vpc.id
  security_group_ids = [aws_security_group.gradle.id]
}

module "nexus" {
  source             = "./modules/nexus"
  instance_type      = var.nexus_instance_type
  ami                = var.nexus_ami
  key_name           = var.key_name
  subnet_id          = aws_subnet.cicd_vpc.id
  security_group_ids = [aws_security_group.nexus.id]
}
