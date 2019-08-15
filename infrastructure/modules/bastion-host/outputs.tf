output "instance_name" {
  value = "${google_compute_instance.bastion-host.name}"
}

output "user" {
  value       = "${var.ssh_user}"
  description = "User to be used when ssh to bastion host"
}
