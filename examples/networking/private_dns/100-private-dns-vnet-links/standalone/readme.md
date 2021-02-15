You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/networking/private_dns/100-private-dns-vnet-links/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/networking/private_dns/100-private-dns-vnet-links/ \
  -level level1 \
  -a plan

```

To run this example from TFC
- Change the TFC Terraform Working Directory to examples/networking/private_dns/100-private-dns-vnet-links/standalone/
- Set the execution mode to Agent
- Set the workspace's workflow type to API-driven workflow
- Add the variable logged_aad_app_objectId and set the clientId of the system MSI of the agent
- Set ARM_USE_MSI to true
- Set ARM_SUBSCRIPTION_ID and ARM_TENANT_ID

From the rover go to folder
cd /tf/caf/examples/networking/private_dns/100-private-dns-vnet-links/standalone
terraform login
terraform init
terraform plan / apply
