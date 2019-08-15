provider "google" {
  project     = "${var.project_id}"
  credentials = "${file(var.credentials)}"
  region      = "${var.region}"
}

provider "google-beta" {
  project     = "${var.project_id}"
  credentials = "${file(var.credentials)}"
  region      = "${var.region}"
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
  count  = 2
  name   = "${var.nat_ext_addresses_name_suffix}-${count.index}"
  region = "${var.region}"
}

resource "google_compute_router_nat" "nat-gateway" {
  name                               = "${var.nat_gateway_name}"
  router                             = "${google_compute_router.router.name}"
  region                             = "${var.region}"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = ["${google_compute_address.address[*].self_link}"]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = "${var.private_subnet_name}"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  log_config {
    filter = "TRANSLATIONS_ONLY"
    enable = true
  }
}
