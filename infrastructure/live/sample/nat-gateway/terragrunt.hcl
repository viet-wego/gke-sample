
terraform {
  source = "git::git@github.com:viettd/gke-sample.git//infrastructure/modules/nat-gateway?ref=master"
}

include {
  path = find_in_parent_folders()
}


dependencies {
  paths = ["../vpc", "../firewall"]
}

inputs = {

  vpc_name    = "dev-vpc"
  router_name = "dev-router"

  nat_ext_addresses_name = "dev-nat-gateway"
  nat_gateway_name       = "dev-nat-gateway"
  private_subnet_name    = "dev-gke-cluster-subnet"
}
