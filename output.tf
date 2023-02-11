output "ec2_public_ip" {
  value = module.myapp-server-1.instance.public_ip
}
