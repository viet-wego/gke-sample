
resource "null_resource" "depends_on" {
  triggers = {
    depends_on = "${join("", var.depends)}"
  }
}

data "google_compute_subnetwork" "cluster-subnet" {
  name = "${var.cluster_subnet_name}"
  depends_on = [
    "null_resource.depends_on"
  ]
}


module "private-cluster" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "~> 4.1.0"

  project_id               = "${var.project_id}"
  name                     = "${var.cluster_name}"
  regional                 = false
  region                   = "${var.region}"
  zones                    = ["${var.zone}"]
  network                  = "${var.vpc_name}"
  subnetwork               = "${var.cluster_subnet_name}"
  ip_range_pods            = "${var.po_cidr_range_name}"
  ip_range_services        = "${var.svc_cidr_range_name}"
  service_account          = ""
  enable_private_endpoint  = true
  enable_private_nodes     = true
  remove_default_node_pool = true
  master_ipv4_cidr_block   = "${var.master_cidr}"

  master_authorized_networks_config = [
    {
      cidr_blocks = [
        {
          cidr_block   = "${var.cicd_cidr}"
          display_name = "${var.cicd_subnet_name}"
        },
        {
          cidr_block   = "${var.bastion_hosts_cidr}"
          display_name = "${var.bastion_hosts_subnet_name}"
        }
      ]
    }
  ]
}
