
```bash
# Hub networking
rover -lz /tf/caf/landingzones/caf_networking/ -var-file /tf/caf/landingzones/caf_networking/scenario/200-single-region-hub/configuration.tfvars -tfstate networking_hub.tfstate -a apply


# Set the following variable environment
export example="100-basic"

# Dap spoke network
rover -lz /tf/caf/landingzones/caf_networking/ -var-file /tf/caf/solutions/examples/data_analytics/${example}/networking_spoke.tfvars -tfstate ${example}-networking_spoke.tfstate -a apply

# Machine Learning Workspace
rover -lz /tf/caf/solutions -var-file /tf/caf/solutions/examples/data_analytics/${example}/aml_configuration.tfvars -tfstate ${example}.tfstate -a apply

# Synapse Workspace
rover -lz /tf/caf/solutions -var-file /tf/caf/solutions/examples/data_analytics/${example}/synapse_configuration.tfvars -tfstate ${example}.tfstate -a apply

```