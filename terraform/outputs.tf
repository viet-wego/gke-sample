output "cluster-endpoint" {
  value       = "${module.gke.endpoint}"
  description = "Private endpoint of gke cluster"
}

output "cluster-name" {
  value       = "${module.gke.name}"
  description = "Name of gke cluster"
}
output "bastion-host-instance-name" {
  value       = "${module.bastion-host.instance_name}"
  description = "Name of bastion host VM instance"
}

output "bastion-host-user" {
  value       = "${module.bastion-host.user}"
  description = "User to be used when ssh to bastion host"
}
