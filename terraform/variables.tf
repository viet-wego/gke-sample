
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

variable "subnet_01_name" {
  description = "(Optional) The name of subnet for gke cluster"
  default     = "gke-cluster-subnet"
}
variable "subnet_01_cidr" {
  description = "(Optional) CIDR block for gke worker nodes"
  default     = "10.10.1.0/24"
}
variable "subnet_01_svc_secondary_cidr" {
  description = "(Optional) CIDR block for k8s services, cannot overlap with 172.17.0.0/16"
  default     = "10.10.2.0/24"
}
variable "subnet_01_svc_secondary_range_name" {
  description = "(Optional) Name for k8s services secondary cidr range"
  default     = "svc-cidr"
}
variable "subnet_01_po_secondary_cidr" {
  description = "(Optional) CIDR block for k8s pods, cannot overlap with 172.17.0.0/16"
  default     = "10.11.0.0/16"
}
variable "subnet_01_po_secondary_range_name" {
  description = "(Optional) Name for k8s pods secondary cidr range"
  default     = "po-cidr"
}
variable "subnet_02_name" {
  description = "(Optional) The name of subnet for CI/CD"
  default     = "cicd-subnet"
}
variable "subnet_02_cidr" {
  description = "(Optional) CIDR block of CI/CD"
  default     = "10.20.0.0/24"
}

variable "subnet_03_name" {
  description = "(Optional) The name of subnet for bastion host(s)"
  default     = "bastion-host-subnet"
}
variable "subnet_03_cidr" {
  description = "(Optional) CIDR block for bastion host(s)"
  default     = "10.20.1.0/28"
}

variable "cluster_name" {
  description = "(Optional) Cluster name"
  default     = "gke-sample-cluster"
}

variable "master_cidr" {
  description = "(Optional) CIDR block for master, cannot overlap with 172.17.0.0/16, must be /28"
  default     = "172.16.0.0/28"
}





