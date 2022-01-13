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

* Workspaces
* Hostpools
* Application groups
* Keyvaults(To store: domain admin password, session host VM password, hostpool token)

Note: It is not recommended to have secrets value in the code base and hence the example will insert an empty value. Once the KV is created, admin has to manually update the KV secrets from the portal.
Hostpool token has to be copied to the respective secret from azure portal's Host pools > overview > Registration Key.


| Name of the secret      | Value                                                       |
|-------------------------|-------------------------------------------------------------|
| newwvd-admin-password   | Existing domain user password for AD Join                   |
| newwvd-vm-password      | Admin password to be used for session hosts                 |
| newwvd-hostpool-token   | Host pool token to be used by session hosts                 |


## Run this example

You can run this example directly using Terraform or via rover:


### With rover

To test this deployment in the example landingzone, make sure the launchpad has been deployed first, then run the following command:

```bash
rover \
  -lz /tf/caf/landingzones/caf_example \
  -var-folder  /tf/caf/examples/compute/wvd_resources \
  -level level1 \
  -tfstate wvd-pre.tfstate \
  -a [plan | apply | destroy]
```

This example's tfstate will be stored in the file "wvd-pre.tfstate" which will be read by the session host resources as shown in the folder  /tf/caf/examples/compute/wvd_session_host