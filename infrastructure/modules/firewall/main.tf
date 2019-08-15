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

module "net-firewall" {
  source                  = "terraform-google-modules/network/google//modules/fabric-net-firewall"
  project_id              = "${var.project_id}"
  network                 = "${var.vpc_name}"
  internal_allow          = "true"
  internal_ranges_enabled = "true"
  ssh_source_ranges       = ["0.0.0.0/0"]
}
