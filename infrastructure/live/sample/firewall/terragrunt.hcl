terraform {
  source = "git::git@github.com:viettd/gke-sample.git//infrastructure/modules/firewall?ref=master"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc"]
}

inputs = {
  vpc_name = "dev-vpc"
}
