variable "ssh_public" {
  description = "fileapth for ssh key "
  type        = "string"

  default = "ubuntu_key.pub"
}

 variable "PATH_TO_PRIVATE_KEY" {
  default = "ubuntu_key"
}
