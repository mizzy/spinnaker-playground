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

variable "managing_account_id" {}
variable "managed_account_id" {}

variable "spinnaker_user_public_key" {}

