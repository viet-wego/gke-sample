

##  Infrastructure

Location: `./infrastructure`

        cd infrastructure

Prepare:

- Replace dummy data at `inputs{}` sections with yours:
  - `./live/sample/terragrunt.hcl`: all
  - `./live/sample/bastion-host/terragrunt.hcl`: `ssh_key`

Run:

        # given you're at root level of repo
        cd ./infrastructure/live/sample
        # To verify plan before apply
        terragrunt plan-all
        # To create the infrastructure
        terragrunt apply-all -auto-approve

        # To destroy the infrastructure
        terragrunt destroy-all -auto-approve


##  Application

