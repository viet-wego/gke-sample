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
      subnet_name           = "${var.cluster_subnet_name}"
      subnet_ip             = "${var.cluster_subnet_cidr}"
      subnet_region         = "${var.region}"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = "${var.cicd_subnet_name}"
      subnet_ip             = "${var.cicd_subnet_cidr}"
      subnet_region         = "${var.region}"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = "${var.bastion_host_subnet_name}"
      subnet_ip             = "${var.bastion_host_subnet_cidr}"
      subnet_region         = "${var.region}"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    }
  ]

  secondary_ranges = {
    "${var.cluster_subnet_name}" = [
      {
        range_name    = "${var.cluster_svc_ip_range_name}"
        ip_cidr_range = "${var.cluster_svc_cidr}"
      },
      {
        range_name    = "${var.cluster_po_ip_range_name}"
        ip_cidr_range = "${var.cluster_po_cidr}"
      }
    ]
    "${var.cicd_subnet_name}"         = []
    "${var.bastion_host_subnet_name}" = []
  }
}




