
```bash
# Hub networking
rover -lz /tf/caf/landingzones/caf_networking/ -var-file /tf/caf/landingzones/caf_networking/scenario/200-single-region-hub/configuration.tfvars -tfstate networking_hub.tfstate -a apply


# Set the following variable environment
export example="101-aml"

# Dap spoke network
rover -lz /tf/caf/landingzones/caf_networking/ -var-file /tf/caf/solutions/examples/machine_learning/${example}/networking_spoke.tfvars -tfstate ${example}-networking_spoke.tfstate -a apply

# Machine Learning Workspace
rover -lz /tf/caf/solutions -var-file /tf/caf/solutions/examples/machine_learning/${example}/configuration.tfvars -tfstate ${example}.tfstate -a apply

```