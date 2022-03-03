module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# storage_data_lake_gen2_filesystem

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Data Lake Gen2 File System which should be created within the Storage Account. Must be unique within the storage account the queue is located. Changing this forces a new resource to be created.||True|
|storage_account|The `storage_account` block as defined below.|Block|True|
|properties| A mapping of Key to Base64-Encoded Values which should be assigned to this Data Lake Gen2 File System.||False|
|ace| One or more `ace` blocks as defined below to specify the entries for the ACL for the path.| Block |False|
|owner| Specifies the Object ID of the Azure Active Directory User to make the owning user of the root path (i.e. `/`).||False|
|group| Specifies the Object ID of the Azure Active Directory Group to make the owning group of the root path (i.e. `/`).||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|storage_account| key | Key for  storage_account||| Required if  |
|storage_account| lz_key |Landing Zone Key in wich the storage_account is located|||True|
|storage_account| id | The id of the storage_account |||True|
|ace|scope| Specifies whether the ACE represents an `access` entry or a `default` entry. Default value is `access`.|||False|
|ace|type| Specifies the type of entry. Can be `user`, `group`, `mask` or `other`.|||True|
|ace|id| Specifies the Object ID of the Azure Active Directory User or Group that the entry relates to. Only valid for `user` or `group` entries.|||False|
|ace|permissions| Specifies the permissions for the entry in `rwx` form. For example, `rwx` gives full permissions but `r--` only gives read permissions.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Data Lake Gen2 File System.|||
