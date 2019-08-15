

##  Infrastructure

### Architecture

![image](./infrastructure/gke-sample-architect.jpg)

### Pre-requisites 

- Install [Terraform](https://www.terraform.io/) version `0.12.0` or newer.
- Install [Terragrunt](https://github.com/gruntwork-io/terragrunt) version `v0.19.0` or newer.
- Install [Google Cloud SDK](https://cloud.google.com/sdk/) version `257.0.0` or newer.

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

### Access cluster:

- Get instance name & user to ssh to created bastion host

        terragrunt output-all | grep instance_name
        terragrunt output-all | grep user

- SSH to bastion host using `gcloud` CLI

        gcloud compute ssh <user>@<instance_name>

- The `kubectl` tool & `kubeconfig` are already set up on bastion host. You can just start using it:

        kubectl get po --all-namespaces


##  Application

