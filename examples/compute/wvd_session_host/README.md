# Windows Virtual Desktop 

This sub module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this module inside your Terraform code either as a module or as a sub module directly from the [Terraform Registry](https://registry.terraform.io/modules/aztfmod/caf/azurerm/latest) using the following calls:

Complete module:
```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.3.2"
  # insert the 6 required variables here
}
```

## This example creates following WVD resources

* Session host VMs
* vNet and subnets for session host VMs

Note: Make sure that the secret values are manually update in respective keyvaults created in /tf/caf/examples/compute/wvd_resources. 


## Run this example with rover

To test this deployment in the example landingzone, make sure the launchpad has been deployed first, make sure that the hostpool,workspace,application groups and keyvaults are already created as in /tf/caf/examples/compute/wvd_resources folder and then run the following command:


```bash
rover \
  -lz /tf/caf/examples \
  -var-folder  /tf/caf/examples/compute/wvd_session_host \
  -level level1 \
  -tfstate wvd-post.tfstate \
  -a [plan | apply | destroy]
```

```bash


Note: If your ADDS is in another vnet as WVD VM vNet, you have to update dns servers as in ADDS and peer with AADDS vnet before you create session hosts.  

