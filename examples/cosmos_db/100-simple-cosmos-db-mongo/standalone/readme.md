You can test this module outside of a landingzone using

```bash
terraform init

terraform [plan|apply|destroy] \ 
  -var-file ../configuration.tfvars \
  -var-file ../keyvaults.tfvars \
  -var-file ../nsg_definitions.tfvars \
  -var-file ../virtual_networks.tfvars \
  -var-file ../public_ip_addresses.tfvars \
  -var-file ../virtual_machines.tfvars


```