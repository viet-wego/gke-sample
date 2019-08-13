output "vpc" {
  value       = "${module.vpc.network_name}"
  description = "Self link of the VPC"
}

output "subnets" {
  value       = "${module.vpc.subnets_names}"
  description = "Self links of subnets"
}

output "lol" {
  value       = "${module.vpc.subnets_secondary_ranges}"
  description = "Secondary ip ranges"
}

output "name" {
  value = "${module.vpc.subnets_regions}"
}
