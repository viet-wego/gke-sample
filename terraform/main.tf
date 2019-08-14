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
  source = "./modules/gke"

  project_id                = "${var.project_id}"
  cluster_name              = "${var.cluster_name}"
  region                    = "${var.region}"
  zone                      = "${var.zone}"
  vpc_name                  = "${module.vpc.network_name}"
  cluster_subnet_name       = "${module.vpc.subnets_names[0]}"
  po_cidr_range_name        = "${var.subnet_01_po_secondary_range_name}"
  svc_cidr_range_name       = "${var.subnet_01_svc_secondary_range_name}"
  master_cidr               = "${var.master_cidr}"
  cicd_cidr                 = "${module.vpc.subnets_ips[1]}"
  cicd_subnet_name          = "${module.vpc.subnets_names[1]}"
  bastion_hosts_cidr        = "${module.vpc.subnets_ips[2]}"
  bastion_hosts_subnet_name = "${module.vpc.subnets_names[2]}"

  depends = ["${module.vpc.network_name}"]
}


module "service-account" {
  source                         = "./modules/service-account"
  developer_service_account_name = "${var.developer_service_account_name}"
  project_id                     = "${var.project_id}"
}

module "bastion-host" {
  source           = "./modules/bastion-host"
  zone             = "${var.zone}"
  name             = "${var.bastion_host_name}"
  subnetwork       = "${var.subnet_03_name}"
  service_account  = "${module.service-account.service_account_email}"
  ssh_key          = "${var.ssh_key}"
  gke_cluster_name = "${var.cluster_name}"
}



