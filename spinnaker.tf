module "spinnaker" {
  source = "./module/spinnaker"
  key_name = "your_ssh_key_name"
  
  /* These are defaults. You can overrive them.
    instance_type = "c5.large"
    security_group = "default"
    volume_size = "100"
  */
}

output "public_dns" {
  value = "${module.spinnaker.public_dns}"
}
