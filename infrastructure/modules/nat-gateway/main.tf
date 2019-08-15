provider "google" {
  version     = "~> 2.12"
  project     = "${var.project_id}"
  credentials = "${file(var.credentials)}"
  region      = "${var.region}"
}

provider "google-beta" {
  version     = "~> 2.12"
  project     = "${var.project_id}"
  credentials = "${file(var.credentials)}"
  region      = "${var.region}"
}

data "google_compute_subnetwork" "private-subnet" {
  name   = "${var.private_subnet_name}"
  region = "${var.region}"
}

resource "google_compute_router" "router" {
  name    = "${var.router_name}"
  region  = "${var.region}"
  network = "${var.vpc_name}"
  bgp {
    asn = 64514
  }
}

resource "google_compute_address" "address" {
  name   = "${var.nat_ext_addresses_name}"
  region = "${var.region}"
}

resource "google_compute_router_nat" "nat-gateway" {
  name                               = "${var.nat_gateway_name}"
  router                             = "${google_compute_router.router.name}"
  region                             = "${var.region}"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = ["${google_compute_address.address.self_link}"]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = "${data.google_compute_subnetwork.private-subnet.self_link}"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  log_config {
    filter = "TRANSLATIONS_ONLY"
    enable = true
  }
}
