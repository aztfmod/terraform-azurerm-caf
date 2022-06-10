


## Terraform Cloud - local exec

```
export BACKEND_type_hybrid=false
export TF_CLOUD_ORGANIZATION=<change>
export TF_VAR_environment=<change>
export TF_VAR_level=level1
export TF_VAR_backend_type=remote

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/examples/compute/virtual_machine/112-ssh-key \
  -target_subscription xxxxxx \
  -tfstate example.tfstate \
  -a plan

```