You can test this module outside of a landingzone using

```bash
terraform init

terraform [plan|apply|destroy] \ 
  -var-file ../application_gateways.tfvars  \
  -var-file ../application.tfvars \
  -var-file ../certificates.tfvars \
  -var-file ../configuration.tfvars \
  -var-file ../keyvaults.tfvars \
  -var-file ../nsg_definition.tfvars  \
  -var-file ../public_ip_addresses.tfvars \
  -var-file ../virtual_network.tfvars \
  -var-file ../managed_identities.tfvars

```