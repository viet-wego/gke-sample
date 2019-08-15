
terraform {
  source = "git::git@github.com:viettd/gke-sample.git//infrastructure/modules/vpc?ref=master"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  vpc_name                  = "dev-vpc"
  cluster_subnet_name       = "dev-gke-cluster-subnet"
  cluster_subnet_cidr       = "10.10.1.0/24"
  cluster_svc_cidr          = "10.10.2.0/24"
  cluster_svc_ip_range_name = "dev-svc-cidr"
  cluster_po_cidr           = "10.11.0.0/16"
  cluster_po_ip_range_name  = "dev-po-cidr"
  cicd_subnet_name          = "dev-cicd-subnet"
  cicd_subnet_cidr          = "10.20.0.0/24"
  bastion_host_subnet_name  = "dev-bastion-host-subnet"
  bastion_host_subnet_cidr  = "10.20.1.0/28"
}
