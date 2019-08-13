provider "google" {
  project     = "${var.project_id}"
  region      = "${var.region}"
  credentials = "${file(var.credentials)}"
}

provider "google-beta" {
  project     = "${var.project_id}"
  region      = "${var.region}"
  credentials = "${file(var.credentials)}"
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 1.1.0"

  project_id   = "${var.project_id}"
  network_name = "${var.vpc_name}"
  routing_mode = "REGIONAL"

  subnets = [
    {
      subnet_name           = "${var.subnet_01_name}"
      subnet_ip             = "${var.subnet_01_cidr}"
      subnet_region         = "${var.region}"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = "${var.subnet_02_name}"
      subnet_ip             = "${var.subnet_02_cidr}"
      subnet_region         = "${var.region}"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = "${var.subnet_03_name}"
      subnet_ip             = "${var.subnet_03_cidr}"
      subnet_region         = "${var.region}"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    }
  ]

  secondary_ranges = {
    "${var.subnet_01_name}" = [
      {
        range_name    = "${var.subnet_01_svc_secondary_range_name}"
        ip_cidr_range = "${var.subnet_01_svc_secondary_cidr}"
      },
      {
        range_name    = "${var.subnet_01_po_secondary_range_name}"
        ip_cidr_range = "${var.subnet_01_po_secondary_cidr}"
      }
    ]
    "${var.subnet_02_name}" = []
    "${var.subnet_03_name}" = []
  }
}

module "net-firewall" {
  source                  = "terraform-google-modules/network/google//modules/fabric-net-firewall"
  project_id              = "${var.project_id}"
  network                 = "${module.vpc.network_name}"
  internal_allow          = "true"
  internal_ranges_enabled = "true"
  internal_ranges         = "${module.vpc.subnets_ips}"
  ssh_source_ranges       = ["0.0.0.0/0"]
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "~> 4.1.0"

  project_id = "${var.project_id}"
  name       = "${var.cluster_name}"
  regional   = false
  region     = "${var.region}"
  zones      = ["${var.zone}"]
  network    = "${module.vpc.network_name}"
  subnetwork = "${module.vpc.subnets_names[0]}"
  #cluster_ipv4_cidr       = "${module.vpc.subnets_ips[0]}"
  ip_range_pods            = "${module.vpc.subnets_secondary_ranges[0][1].range_name}"
  ip_range_services        = "${module.vpc.subnets_secondary_ranges[0][0].range_name}"
  service_account          = ""
  enable_private_endpoint  = true
  enable_private_nodes     = true
  remove_default_node_pool = true
  master_ipv4_cidr_block   = "${var.master_cidr}"

  master_authorized_networks_config = [
    {
      cidr_blocks = [
        {
          cidr_block   = "${module.vpc.subnets_ips[1]}"
          display_name = "${module.vpc.subnets_names[1]}"
        },
        {
          cidr_block   = "${module.vpc.subnets_ips[2]}"
          display_name = "${module.vpc.subnets_names[2]}"
        }
      ]
    }
  ]
}
