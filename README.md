

##  Infrastructure

### Architecture

![image](./infrastructure/gke-sample-architect.jpg)

### Pre-requisites 

- Install [Terraform](https://www.terraform.io/) version `0.12.0` or newer.
- Install [Terragrunt](https://github.com/gruntwork-io/terragrunt) version `v0.19.0` or newer.

### Prepare data:

- Replace dummy data at `inputs{}` sections with yours:
  - `./infrastructure/live/sample/terragrunt.hcl`: all inputs
  - `./infrastructure/live/sample/bastion-host/terragrunt.hcl`: `ssh_key`

### Deploy:

        # given you're at root level of repo
        cd ./infrastructure/live/sample
        # To verify plan before apply
        terragrunt plan-all
        # To create the infrastructure
        terragrunt apply-all -auto-approve

        # To destroy the infrastructure
        terragrunt destroy-all -auto-approve


##  Application

