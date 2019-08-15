
provider "google" {
  version     = "~> 2.12"
  project     = "${var.project_id}"
  region      = "${var.region}"
  credentials = "${file(var.credentials)}"
}

provider "google-beta" {
  version     = "~> 2.12"
  project     = "${var.project_id}"
  region      = "${var.region}"
  credentials = "${file(var.credentials)}"
}
module "private-cluster" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "~> 4.1.0"

  project_id               = "${var.project_id}"
  name                     = "${var.gke_cluster_name}"
  regional                 = false
  region                   = "${var.region}"
  zones                    = ["${var.zone}"]
  network                  = "${var.vpc_name}"
  subnetwork               = "${var.cluster_subnet_name}"
  ip_range_pods            = "${var.cluster_po_ip_range_name}"
  ip_range_services        = "${var.cluster_svc_ip_range_name}"
  service_account          = ""
  enable_private_endpoint  = true
  enable_private_nodes     = true
  remove_default_node_pool = true
  master_ipv4_cidr_block   = "${var.master_cidr}"

  master_authorized_networks_config = [
    {
      cidr_blocks = [
        {
          cidr_block   = "${var.cicd_subnet_cidr}"
          display_name = "${var.cicd_subnet_name}"
        },
        {
          cidr_block   = "${var.bastion_host_subnet_cidr}"
          display_name = "${var.bastion_host_subnet_name}"
        }
      ]
    }
  ]
}
