# Spinnaker Playground

## Setup spinnaker

Edit `spinnaker.tf`

```hcl
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
```

Run terraform to create ec2 instance.

```
$ terraform init
$ terraform apply
```

Run setup.sh to setup spinnaker.

```
$ ssh ec2-xx-xx-xx-xx.ap-northeast-1.compute.amazonaws.com \
  'curl -s https://raw.githubusercontent.com/mizzy/spinnaker-playground/master/setup.sh | sh'
```

Acccess to `http://ec2-xx-xx-xx-xx.ap-northeast-1.compute.amazonaws.com:9000` .


## Remove spinnaker setup

```
$ terreform destroy
```
