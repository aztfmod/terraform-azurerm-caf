
```bash
# Hub networking
rover -lz /tf/caf/landingzones/caf_networking/ -var-file /tf/caf/landingzones/caf_networking/scenario/200-single-region-hub/configuration.tfvars -tfstate networking_hub.tfstate -a apply

# Set the following variable environment
export example="200-private-dns-vnet-links"

# Private dns
rover -lz /tf/caf/solutions -var-file /tf/caf/solutions/examples/networking/private_dns/${example}/configuration.tfvars -tfstate ${example}.tfstate -a apply

```