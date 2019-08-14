variable "zone" {
  description = "The zone where we will deploy the instance"
}

variable "name" {
  description = "Name of the instance"
}

variable "subnetwork" {
  description = "Name of the network the instance will be deployed to"
}

variable "service_account" {
  description = "Service account email to be configurated for the instance"
}


variable "ssh_key" {
  description = "SSH private key file path to execute initial command"
}

variable "gke_cluster_name" {
  description = "GKE cluster name to initialize the credentials for kubectl"
}

variable "ssh_user" {
  description = "(Optional) User to be used when ssh to the bastion host"
  default     = "dev"
}

