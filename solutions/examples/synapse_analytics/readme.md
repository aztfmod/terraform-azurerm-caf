
```bash
# Hub networking
rover -lz /tf/caf/landingzones/caf_networking/ -var-file /tf/caf/landingzones/caf_networking/scenario/200-single-region-hub/configuration.tfvars -tfstate networking_hub.tfstate -a apply


# Set the following variable environment for basic workspace
export example="100-synapse"

# To setup the advance configuration and compute resources set env variable
# sql pool
# spark pool
export example="101-synapse"

# Dap spoke network
rover -lz /tf/caf/landingzones/caf_networking/ -var-file /tf/caf/solutions/examples/synapse_analytics/${example}/networking_spoke.tfvars -tfstate ${example}-networking_spoke.tfstate -a apply

# Synapse Workspace
rover -lz /tf/caf/solutions -var-file /tf/caf/solutions/examples/synapse_analytics/${example}/configuration.tfvars -tfstate ${example}.tfstate -a apply

```