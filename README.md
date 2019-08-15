

##  Infrastructure

Location: `./terraform`

        cd terraform

Prepare:

- You need to create a variables named `my_vars.tfvars` with the content below:

        # Your gcp project id
        project_id  = "your-project-id"

        # Path to json private key file of your service account (make sure it has sufficient permissions (I'm testing using admin) on IAM, Compute Engine,  Network, Kubernetes Engine ) 
        credentials = "/path/to/private-key.json"

        # Path to your gcp compute engine rsa private key
        ssh_key     = "/path/to/gcp-compute-engine-rsa-private-key"


Run:

        # Install all necessary plugins & dependencies
        terraform init
        # To verify plan before apply
        terraform plan -var-file=my_vars.tfvars
        # Apply the plan to create infrastructure
        terraform apply -var-file=my_vars.tfvars -auto-approve

Clean up:

        terraform destroy -var-file=z_vars.tfvars -auto-approve

##  Application

