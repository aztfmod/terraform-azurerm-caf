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
This is a pre-requisite for WVD.

## Run this example

You can run this example directly using Terraform or via rover:


### With rover

To test this deployment in the example landingzone, make sure the launchpad has been deployed first, then run the following command:

```bash
rover \
  -lz /tf/caf/examples \
  -var-folder  /tf/caf/examples/compute/wvd_pre-requisit \
  -level level1 \
  -tfstate wvd-pre.tfstate \
  -a [plan | apply | destroy]
```