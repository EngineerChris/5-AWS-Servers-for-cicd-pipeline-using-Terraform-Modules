variable "instance_type" {
  description = "The instance type to use for the Maven server"
  type        = string
}

variable "ami" {
  description = "The AMI to use for the Maven server"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}
