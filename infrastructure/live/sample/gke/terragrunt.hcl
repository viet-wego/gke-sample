terraform {
  source = "git::git@github.com:viettd/gke-sample.git//infrastructure/modules/gke?ref=master"
}

include {
  path = find_in_parent_folders()
}


dependencies {
  paths = ["../vpc", "../firewall", "../nat-gateway"]
}

inputs = {

  vpc_name                  = "dev-vpc"
  cluster_subnet_name       = "dev-gke-cluster-subnet"
  cluster_svc_ip_range_name = "dev-svc-cidr"
  cluster_po_ip_range_name  = "dev-po-cidr"
  cicd_subnet_name          = "dev-cicd-subnet"
  cicd_subnet_cidr          = "10.20.0.0/24"
  bastion_host_subnet_name  = "dev-bastion-host-subnet"
  bastion_host_subnet_cidr  = "10.20.1.0/28"
  gke_cluster_name          = "dev-gke-cluster"
  master_cidr               = "172.16.0.0/28"
}
