You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/networking/front_door/100-simple-front_door/standalone/

terraform init

terraform plan \
  -var-file ../configuration.tfvars\
  -var-file ../diagnostic_storage_accounts.tfvars \
  -var-file ../diagnostics_definition.tfvars \
  -var-file ../diagnostics_destinations.tfvars\
  -var-file ../dns_zone.tfvars \
  -var-file ../front_door_waf_policies.tfvars \
  -var-file ../front_doors.tfvars \
  -var-file ../keyvault_certificate_requests.tfvars \
  -var-file ../keyvault.tfvars


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/networking/front_door/100-simple-front_door/ \
  -level level1 \
  -a plan

```