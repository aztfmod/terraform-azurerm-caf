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
|local_auth_enabled| *(Currently Disabled) Whether local authentication methods is enabled. Defaults to `true`. Changing this forces a new Machine Learning Compute Instance to be created.||False|
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
