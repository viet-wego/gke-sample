
variable "project_id" {
  description = "The project where we will deploy this"
}
variable "credentials" {
  description = "Path to JSON key file"
}

variable "region" {
  description = "(Optional) The region where we will deploy this"
  default     = "asia-southeast1"
}
variable "zone" {
  description = "(Optional) The zone where we will deploy this"
  default     = "asia-southeast1-b"
}

variable "vpc_name" {
  description = "(Optional) The name of our VPC"
  default     = "gke-sample"
}

variable "cluster_subnet_name" {
  description = "(Optional) The name of subnet for gke cluster"
  default     = "gke-cluster-subnet"
}
variable "cluster_subnet_cidr" {
  description = "(Optional) CIDR block for gke worker nodes"
  default     = "10.10.1.0/24"
}
variable "cluster_svc_cidr" {
  description = "(Optional) CIDR block for k8s services, cannot overlap with 172.17.0.0/16"
  default     = "10.10.2.0/24"
}
variable "cluster_svc_ip_range_name" {
  description = "(Optional) Name for k8s services secondary cidr range"
  default     = "svc-cidr"
}
variable "cluster_po_cidr" {
  description = "(Optional) CIDR block for k8s pods, cannot overlap with 172.17.0.0/16"
  default     = "10.11.0.0/16"
}
variable "cluster_po_ip_range_name" {
  description = "(Optional) Name for k8s pods secondary cidr range"
  default     = "po-cidr"
}
variable "cicd_subnet_name" {
  description = "(Optional) The name of subnet for CI/CD"
  default     = "cicd-subnet"
}
variable "cicd_subnet_cidr" {
  description = "(Optional) CIDR block for CI/CD"
  default     = "10.20.0.0/24"
}

variable "bastion_host_subnet_name" {
  description = "(Optional) The name of subnet for bastion host(s)"
  default     = "bastion-host-subnet"
}
variable "bastion_host_subnet_cidr" {
  description = "(Optional) CIDR block for bastion host(s)"
  default     = "10.20.1.0/28"
}

variable "gke_cluster_name" {
  description = "(Optional) Cluster name"
  default     = "gke-sample-cluster"
}

variable "master_cidr" {
  description = "(Optional) CIDR block for master, cannot overlap with 172.17.0.0/16, must be /28"
  default     = "172.16.0.0/28"
}
