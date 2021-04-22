# Windows Virtual Desktop 

This sub module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this module inside your Terraform code either as a module or as a sub module directly from the [Terraform Registry](https://registry.terraform.io/modules/aztfmod/caf/azurerm/latest) using the following calls:

Complete module:
```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "4.21.2"
  # insert the 6 required variables here
}
```


## Run this example with rover

To test this deployment in the example landingzone, make sure the launchpad has been deployed first, make sure that you run the pre-requisit in /tf/caf/examples/compute/wvd_pre-requisit folder and then run the following command:


For Desktopapp, you may run following 

```bash
rover \
  -lz /tf/caf/examples \
  -var-file /tf/caf/examples/compute/wvd_resources//wvd_desktop_app.tfvars \
  -level level1 \
  -tfstate wvd-post.tfstate \
  -a [plan | apply | destroy]
```

```bash



For remoteapp, you may run following 

rover \
  -lz /tf/caf/examples \
  -var-file /tf/caf/examples/compute/wvd_resources//wvd_remote_app.tfvars \
  -level level1 \
  -tfstate wvd-post.tfstate \
  -a [plan | apply | destroy]
```

-var-file /tf/caf/examples/compute/wvd_resources//wvd_desktop_app.tfvars -var-file /tf/caf/examples/compute/wvd_resources//wvd_remote_app.tfvars

Note: If your ADDS is in another vnet as WVD VM vNet, you have to update dns servers as in ADDS and peer with AADDS vnet.  

