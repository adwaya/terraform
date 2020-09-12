variable "ami_id" {
    description = "AMI id from which instance has to be created"
    type        = string
    default     = "ami-0cc0a36f626a4fdf5"
}

variable "ssh_user" {
  description = "SSH user name to use for remote exec connections,"
  default     = "ubuntu"
}
