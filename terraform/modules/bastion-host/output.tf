output "instance_name" {
  value = "${var.name}"
}

output "user" {
  value       = "${var.ssh_user}"
  description = "User to be used when ssh to bastion host"
}
