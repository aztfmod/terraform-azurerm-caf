# Azure NetApp

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

# netapp_account

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the NetApp Account. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|active_directory| A `active_directory` block as defined below.| Block |False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|active_directory|dns_servers| A list of DNS server IP addresses for the Active Directory domain. Only allows `IPv4` address.|||True|
|active_directory|domain| The name of the Active Directory domain.|||True|
|active_directory|smb_server_name| The NetBIOS name which should be used for the NetApp SMB Server, which will be registered as a computer account in the AD and used to mount volumes.|||True|
|active_directory|username| The Username of Active Directory Domain Administrator.|||True|
|active_directory|password| The password associated with the `username`.|||True|
|active_directory|organizational_unit| The Organizational Unit (OU) within the Active Directory Domain.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the NetApp Account.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# netapp_pool

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the NetApp Pool. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|account_name| The name of the NetApp account in which the NetApp Pool should be created. Changing this forces a new resource to be created.||True|
| region |The region_key where the resource will be deployed|String|True|
|service_level| The service level of the file system. Valid values include `Premium`, `Standard`, or `Ultra`. Changing this forces a new resource to be created.||True|
|size_in_tb| Provisioned size of the pool in TB. Value must be between `4` and `500`.||True|
|qos_type| QoS Type of the pool. Valid values include `Auto` or `Manual`.||False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the NetApp Pool.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# netapp_snapshot

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the NetApp Snapshot. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|account_name| The name of the NetApp account in which the NetApp Pool should be created. Changing this forces a new resource to be created.||True|
|pool_name| The name of the NetApp pool in which the NetApp Volume should be created. Changing this forces a new resource to be created.||True|
|volume_name| The name of the NetApp volume in which the NetApp Snapshot should be created. Changing this forces a new resource to be created.||True|
| region |The region_key where the resource will be deployed|String|True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the NetApp Snapshot.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# netapp_volume

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the NetApp Volume. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|account_name| The name of the NetApp account in which the NetApp Pool should be created. Changing this forces a new resource to be created.||True|
|volume_path| A unique file path for the volume. Used when creating mount targets. Changing this forces a new resource to be created.||True|
|pool_name| The name of the NetApp pool in which the NetApp Volume should be created. Changing this forces a new resource to be created.||True|
|service_level| The target performance of the file system. Valid values include `Premium`, `Standard`, or `Ultra`.||True|
|protocols| The target volume protocol expressed as a list. Supported single value include `CIFS`, `NFSv3`, or `NFSv4.1`. If argument is not defined it will default to `NFSv3`. Changing this forces a new resource to be created and data will be lost. Dual protocol scenario is supported for CIFS and NFSv3, for more information, please refer to [Create a dual-protocol volume for Azure NetApp Files](https://docs.microsoft.com/en-us/azure/azure-netapp-files/create-volumes-dual-protocol) document.||False|
|security_style| Volume security style, accepted values are `Unix` or `Ntfs`. If not provided, single-protocol volume is created defaulting to `Unix` if it is `NFSv3` or `NFSv4.1` volume, if `CIFS`, it will default to `Ntfs`. In a dual-protocol volume, if not provided, its value will be `Ntfs`.||False|
|subnet|The `subnet` block as defined below.|Block|True|
|storage_quota_in_gb| The maximum Storage Quota allowed for a file system in Gigabytes.||True|
|snapshot_directory_visible| Specifies whether the .snapshot (NFS clients) or ~snapshot (SMB clients) path of a volume is visible, default value is true.||False|
|create_from_snapshot_resource_id| Creates volume from snapshot. Following properties must be the same as the original volume where the snapshot was taken from: `protocols`, `subnet_id`, `location`, `service_level`, `resource_group_name`, `account_name` and `pool_name`.||False|
|data_protection_replication| A `data_protection_replication` block as defined below.||False|
|data_protection_snapshot_policy| A `data_protection_snapshot_policy` block as defined below.||False|
|export_policy_rule| One or more `export_policy_rule` block defined below.| Block |False|
|throughput_in_mibps| Throughput of this volume in Mibps.||False|
|tags| A mapping of tags to assign to the resource.||False|
|rule_index| The index number of the rule.||True|
|allowed_clients| A list of allowed clients IPv4 addresses.||True|
|protocols_enabled| A list of allowed protocols. Valid values include `CIFS`, `NFSv3`, or `NFSv4.1`. Only one value is supported at this time. This replaces the previous arguments: `cifs_enabled`, `nfsv3_enabled` and `nfsv4_enabled`.||False|
|unix_read_only| Is the file system on unix read only?||False|
|unix_read_write| Is the file system on unix read and write?||False|
|root_access_enabled| Is root access permitted to this volume?||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|subnet| key | Key for  subnet||| Required if  |
|subnet| lz_key |Landing Zone Key in wich the subnet is located|||True|
|subnet| id | The id of the subnet |||True|
|export_policy_rule|rule_index| The index number of the rule.|||True|
|export_policy_rule|allowed_clients| A list of allowed clients IPv4 addresses.|||True|
|export_policy_rule|protocols_enabled| A list of allowed protocols. Valid values include `CIFS`, `NFSv3`, or `NFSv4.1`. Only one value is supported at this time. This replaces the previous arguments: `cifs_enabled`, `nfsv3_enabled` and `nfsv4_enabled`.|||False|
|export_policy_rule|unix_read_only| Is the file system on unix read only?|||False|
|export_policy_rule|unix_read_write| Is the file system on unix read and write?|||False|
|export_policy_rule|root_access_enabled| Is root access permitted to this volume?|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the NetApp Volume.|||
|mount_ip_addresses|A list of IPv4 Addresses which should be used to mount the volume.|||
