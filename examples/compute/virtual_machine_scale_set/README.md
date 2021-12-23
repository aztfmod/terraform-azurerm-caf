module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# virtual_machine_scale_set

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the virtual machine scale set resource. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|network_profile| A collection of network profile block as documented below.||True|
|os_profile| A Virtual Machine OS Profile block as documented below.||True|
|os_profile_windows_config| A Windows config block as documented below.||False|
|os_profile_linux_config| A Linux config block as documented below.||False|
|proximity_placement_group|The `proximity_placement_group` block as defined below.|Block|False|
|sku| A sku block as documented below.||True|
|storage_profile_os_disk| A storage profile os disk block as documented below||True|
|upgrade_policy_mode| Specifies the mode of an upgrade to virtual machines in the scale set. Possible values, `Rolling`, `Manual`, or `Automatic`. When choosing `Rolling`, you will need to set a health probe.||True|
|automatic_os_upgrade| Automatic OS patches can be applied by Azure to your scaleset. This is particularly useful when `upgrade_policy_mode` is set to `Rolling`. Defaults to `false`.||False|
|boot_diagnostics| A boot diagnostics profile block as referenced below.||False|
|extension| Can be specified multiple times to add extension profiles to the scale set. Each `extension` block supports the fields documented below.||False|
|eviction_policy| Specifies the eviction policy for Virtual Machines in this Scale Set. Possible values are `Deallocate` and `Delete`.||False|
|eviction_policy| Specifies the eviction policy for Virtual Machines in this Scale Set. Possible values are `Deallocate` and `Delete`.||False|
|health_probe_id| Specifies the identifier for the load balancer health probe. Required when using `Rolling` as your `upgrade_policy_mode`.||False|
|license_type| Specifies the Windows OS license type. If supplied, the only allowed values are `Windows_Client` and `Windows_Server`.||False|
|os_profile_secrets| A collection of Secret blocks as documented below.||False|
|overprovision| Specifies whether the virtual machine scale set should be overprovisioned. Defaults to `true`.||False|
|plan| A plan block as documented below.||False|
|priority| Specifies the priority for the Virtual Machines in the Scale Set. Defaults to `Regular`. Possible values are `Low` and `Regular`.||False|
|rolling_upgrade_policy| A `rolling_upgrade_policy` block as defined below. This is only applicable when the `upgrade_policy_mode` is `Rolling`.||False|
|single_placement_group| Specifies whether the scale set is limited to a single placement group with a maximum size of 100 virtual machines. If set to false, managed disks must be used. Default is true. Changing this forces a new resource to be created. See [documentation](http://docs.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-placement-groups) for more information.||False|
|storage_profile_data_disk| A storage profile data disk block as documented below||False|
|storage_profile_image_reference| A storage profile image reference block as documented below.||False|
|tags| A mapping of tags to assign to the resource.||False|
|zones| A collection of availability zones to spread the Virtual Machines over.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|proximity_placement_group| key | Key for  proximity_placement_group||| Required if  |
|proximity_placement_group| lz_key |Landing Zone Key in wich the proximity_placement_group is located|||False|
|proximity_placement_group| id | The id of the proximity_placement_group |||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The virtual machine scale set ID.|||
