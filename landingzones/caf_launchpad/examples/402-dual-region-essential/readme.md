
# Review the configuration file

* Adjust the default location
* Define the regions where the services are deployed
* Deploy a diagnostics logging storage account on those locations

```bash
cd /tf/caf

#  to deploy the launchpad
rover -lz $PWD/landingzones/caf_launchpad -launchpad -var-file $PWD/landingzones/caf_launchpad/examples/402-dual-region-essential/configuration.tfvars -parallelism=30 -a apply

# to destroy the launchpad landing zone
rover -lz $PWD/landingzones/caf_launchpad -launchpad -var-file $PWD/landingzones/caf_launchpad/examples/402-dual-region-essential/configuration.tfvars -parallelism=30 -a destroy
```