variable "depends" {
  default = []
}

variable "project_id" {
  description = "The project where we will deploy this"
}
variable "region" {
  description = "The region where we will deploy this"
}
variable "zone" {
  description = "The zone where we will deploy this"
}

variable "vpc_name" {
  description = "The name of our VPC"
}

variable "cluster_subnet_name" {
  description = "The name of subnet for gke cluster"
}
variable "svc_cidr_range_name" {
  description = "Name for k8s services secondary cidr range"
}
variable "po_cidr_range_name" {
  description = "Name for k8s pods secondary cidr range"
}
variable "cicd_subnet_name" {
  description = "The name of subnet for CI/CD"
}
variable "cicd_cidr" {
  description = "CIDR block of CI/CD"
}

variable "bastion_hosts_subnet_name" {
  description = "The name of subnet for bastion host(s)"
}
variable "bastion_hosts_cidr" {
  description = "CIDR block for bastion host(s)"
}

variable "cluster_name" {
  description = "Cluster name"
}

variable "master_cidr" {
  description = "CIDR block for master, cannot overlap with 172.17.0.0/16, must be /28"
}
