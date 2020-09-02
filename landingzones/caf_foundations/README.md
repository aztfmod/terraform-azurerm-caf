Deploy the launchpad services in the level1 layer.

# Review the configuration file

```bash
cd /tf/caf

#  to deploy the CAF Foundations
rover -lz /tf/caf/landingzones/caf_foundations -a apply -w tfstate

# to destroy the CAF Foundations
rover -lz /tf/caf/landingzones/caf_foundations -a destroy -w tfstate
```
