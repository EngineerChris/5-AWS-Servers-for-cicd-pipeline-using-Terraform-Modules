variable "aws_region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "jenkins_instance_type" {
  description = "The instance type to use for the Jenkins server"
  type        = string
  default     = "t2.medium"
}

variable "jenkins_ami" {
  description = "The AMI to use for the Jenkins server"
  type        = string
}

variable "maven_instance_type" {
  description = "The instance type to use for the Maven server"
  type        = string
  default     = "t2.micro"
}

variable "maven_ami" {
  description = "The AMI to use for the Maven server"
  type        = string
}

variable "sonarqube_instance_type" {
  description = "The instance type to use for the SonarQube server"
  type        = string
  default     = "t2.medium"
}

variable "sonarqube_ami" {
  description = "The AMI to use for the SonarQube server"
  type        = string
}

variable "gradle_instance_type" {
  description = "The instance type to use for the Gradle server"
  type        = string
  default     = "t2.micro"
}

variable "gradle_ami" {
  description = "The AMI to use for the Gradle server"
  type        = string
}

variable "nexus_instance_type" {
  description = "The instance type to use for the Nexus server"
  type        = string
  default     = "t2.medium"
}

variable "nexus_ami" {
  description = "The AMI to use for the Nexus server"
  type        = string
}
