output "cluster-endpoint" {
  value       = "${module.private-cluster.endpoint}"
  description = "Private endpoint of gke cluster"
}

output "cluster-name" {
  value       = "${module.private-cluster.name}"
  description = "Name of gke cluster"
}
