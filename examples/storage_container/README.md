# Azure Storage Account Containers

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.5.0"

  # Add object as described below
}
```

CAF Terraform module is iterative by default, you can instantiate as many objects as needed, using the following structure:

```hcl
resource_to_be_created = {
  object1 = {
    #configuration details as below
  }
  object2 = {
    #configuration details as below
  }
}
```

You can review complete set of examples on the [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/storage_container).

#storage_container

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Container which should be created within the Storage Account.||True|
|storage_account|The `storage_account` block as defined below.|Block|True|
|container_access_type| The Access Level configured for this Container. Possible values are `blob`, `container` or `private`. Defaults to `private`.||False|
|metadata| A mapping of MetaData for this Container. All metadata keys should be lowercase.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|storage_account| key | Key for  storage_account||| Required if  |
|storage_account| lz_key |Landing Zone Key in wich the storage_account is located|||True|
|storage_account| name | The name of the storage_account |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Storage Container.|
|has_immutability_policy|Is there an Immutability Policy configured on this Storage Container?|
|has_legal_hold|Is there a Legal Hold configured on this Storage Container?|
|resource_manager_id|The Resource Manager ID of this Storage Container.|
