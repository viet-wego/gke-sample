variable "project_id" {
  description = "The project where we will deploy this"
}
variable "credentials" {
  description = "Path to JSON key file"
}
variable "ssh_key" {
  description = "SSH private key file path to execute initial command"
}
variable "region" {
  description = "The region where we will deploy this"
  default     = "asia-southeast1"
}
variable "zone" {
  description = "(Optional) The zone where we will deploy this"
  default     = "asia-southeast1-b"
}

variable "bastion_host_name" {
  description = "Name of the bastion host VM instance"
  default     = "bastion-host-01"
}


variable "developer_service_account_name" {
  description = "(Optional) Service account name for developer"
  default     = "developer-sa"
}
variable "gke_cluster_name" {
  description = "GKE cluster name to initialize the credentials for kubectl"
  default     = "gke-sample-cluster"
}
variable "ssh_user" {
  description = "(Optional) User to be used when ssh to the bastion host"
  default     = "dev"
}

variable "bastion_host_subnet_name" {
  description = "(Optional) The name of subnet for bastion host(s)"
  default     = "bastion-host-subnet"
}
