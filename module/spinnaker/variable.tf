variable "key_name" {}

variable "instance_type" {
  default = "c5.large"
}

variable "security_group" {
  default = "default"
}

variable "volume_size" {
  default = "100"
}

