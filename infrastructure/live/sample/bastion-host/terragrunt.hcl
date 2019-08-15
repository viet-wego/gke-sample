terraform {
  source = "git::git@github.com:viettd/gke-sample.git//infrastructure/modules/bastion-host?ref=master"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc", "../firewall", "../nat-gateway", "../gke"]
}

inputs = {
  bastion_host_subnet_name       = "dev-bastion-host-subnet"
  bastion_host_name              = "bastion-host-01"
  developer_service_account_name = "developer-sa"
  ssh_key                        = "/path/to/your/google_compute_engine/rsa/private-key"
  ssh_user                       = "dev"
  gke_cluster_name               = "dev-gke-cluster"
}







