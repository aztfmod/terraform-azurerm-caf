# Azure Compute Resources

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
  # insert the 7 required variables here
}

#vmware_express_route_authorizations
## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|name | he name which should be used for this Express Route Vmware Authorization. Changing this forces a new Vmware Authorization to be created. | `string` |  | true |
|private_cloud_id  | The ID of the Vmware Private Cloud in which to create this Express Route Vmware Authorization. Changing this forces a new Vmware Authorization to be created. | `string` |  | true |
## Outputs
| Name | Description |
|------|-------------|
|id | The ID of the Vmware Authorization.|
| express_route_authorization_id | The ID of the Express Route Circuit Authorization.|
| express_route_authorization_key | The key of the Express Route Circuit Authorization.|