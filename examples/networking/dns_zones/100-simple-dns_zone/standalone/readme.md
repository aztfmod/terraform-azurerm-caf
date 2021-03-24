You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/networking/dns_zones/100-simple-dns_zone/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars \
  -var-file ../dns_zones.tfvars \
  -var-file ../dns_zone_records.tfvars \
  -var-file ../public_ip_addresses.tfvars

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/landingzones/caf_example \
  -var-folder  /tf/caf/examples/networking/dns_zones/100-simple-dns_zone/ \
  -level level1 \
  -a plan

```