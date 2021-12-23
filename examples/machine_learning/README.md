# Azure Machine Learning Workspaces

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
  # insert the 7 required variables here
}
```

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# machine_learning_workspace

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Machine Learning Workspace. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|False|
|application_insights|The `application_insights` block as defined below.|Block|True|
|key_vault|The `key_vault` block as defined below.|Block|True|
|storage_account|The `storage_account` block as defined below.|Block|True|
|identity| An `identity` block as defined below.| Block |True|
|container_registry|The `container_registry` block as defined below.|Block|False|
|public_network_access_enabled| Enable public access when this Machine Learning Workspace is behind VNet.||False|
|image_build_compute_name| The compute name for image build of the Machine Learning Workspace.||False|
|description| The description of this Machine Learning Workspace.||False|
|friendly_name| Display name for this Machine Learning Workspace.||False|
|high_business_impact| Flag to signal High Business Impact (HBI) data in the workspace and reduce diagnostic data collected by the service||False|
|sku_name| SKU/edition of the Machine Learning Workspace, possible values are `Basic`. Defaults to `Basic`.||False|
|tags| A mapping of tags to assign to the resource.||False|
|type| The Type of Identity which should be used for this Azure Machine Learning workspace. At this time the only possible value is `SystemAssigned`.||True|
|key_vault|The `key_vault` block as defined below.|Block|True|
|key_id| The Key Vault URI to access the encryption key.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|application_insights| key | Key for  application_insights||| Required if  |
|application_insights| lz_key |Landing Zone Key in wich the application_insights is located|||True|
|application_insights| id | The id of the application_insights |||True|
|key_vault| key | Key for  key_vault||| Required if  |
|key_vault| lz_key |Landing Zone Key in wich the key_vault is located|||True|
|key_vault| id | The id of the key_vault |||True|
|storage_account| key | Key for  storage_account||| Required if  |
|storage_account| lz_key |Landing Zone Key in wich the storage_account is located|||True|
|storage_account| id | The id of the storage_account |||True|
|identity|type| The Type of Identity which should be used for this Azure Machine Learning workspace. At this time the only possible value is `SystemAssigned`.|||True|
|container_registry| key | Key for  container_registry||| Required if  |
|container_registry| lz_key |Landing Zone Key in wich the container_registry is located|||False|
|container_registry| id | The id of the container_registry |||False|
|key_vault| key | Key for  key_vault||| Required if  |
|key_vault| lz_key |Landing Zone Key in wich the key_vault is located|||True|
|key_vault| id | The id of the key_vault |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Machine Learning Workspace.|||
|discovery_url|The url for the discovery service to identify regional endpoints for machine learning experimentation services.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# machine_learning_compute_instance

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this Machine Learning Compute Instance. Changing this forces a new Machine Learning Compute Instance to be created.||True|
| region |The region_key where the resource will be deployed|String|True|
|machine_learning_workspace|The `machine_learning_workspace` block as defined below.|Block|True|
|virtual_machine_size| The Virtual Machine Size. Changing this forces a new Machine Learning Compute Instance to be created.||True|
|authorization_type| The Compute Instance Authorization type. Possible values include: `personal`. Changing this forces a new Machine Learning Compute Instance to be created.||False|
|assign_to_user| A `assign_to_user` block as defined below. A user explicitly assigned to a personal compute instance. Changing this forces a new Machine Learning Compute Instance to be created.| Block |False|
|description| The description of the Machine Learning Compute Instance. Changing this forces a new Machine Learning Compute Instance to be created.||False|
|identity| An `identity` block as defined below. Changing this forces a new Machine Learning Compute Instance to be created.| Block |False|
|local_auth_enabled| Whether local authentication methods is enabled. Defaults to `true`. Changing this forces a new Machine Learning Compute Instance to be created.||False|
|ssh| A `ssh` block as defined below. Specifies policy and settings for SSH access. Changing this forces a new Machine Learning Compute Instance to be created.| Block |False|
|subnet_resource_id| Virtual network subnet resource ID the compute nodes belong to. Changing this forces a new Machine Learning Compute Instance to be created.||False|
|tags| A mapping of tags which should be assigned to the Machine Learning Compute Instance. Changing this forces a new Machine Learning Compute Instance to be created.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|machine_learning_workspace| key | Key for  machine_learning_workspace||| Required if  |
|machine_learning_workspace| lz_key |Landing Zone Key in wich the machine_learning_workspace is located|||True|
|machine_learning_workspace| id | The id of the machine_learning_workspace |||True|
|assign_to_user|object_id| User�s AAD Object Id.|||False|
|assign_to_user|tenant_id| User�s AAD Tenant Id.|||False|
|identity|type| The Type of Identity which should be used for this Machine Learning Compute Instance. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned,UserAssigned`. Changing this forces a new Machine Learning Compute Instance to be created.|||True|
|identity|identity_ids| A list of User Managed Identity ID's which should be assigned to the Machine Learning Compute Instance. Changing this forces a new Machine Learning Compute Instance to be created.|||False|
|ssh|public_key| Specifies the SSH rsa public key file as a string. Use "ssh-keygen -t rsa -b 2048" to generate your SSH key pairs.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Machine Learning Compute Instance.|||
|identity|An `identity` block as defined below, which contains the Managed Service Identity information for this Machine Learning Compute Instance.|||
|ssh|An `ssh` block as defined below, which specifies policy and settings for SSH access for this Machine Learning Compute Instance.|||
