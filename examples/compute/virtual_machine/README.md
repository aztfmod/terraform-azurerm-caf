module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# virtual_machine

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Virtual Machine. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|network_interface_ids| A list of Network Interface ID's which should be associated with the Virtual Machine.||True|
|os_profile_linux_config| An `os_profile_linux_config` block as defined below.| Block |False|
|os_profile_windows_config| An `os_profile_windows_config` block as defined below.| Block |False|
|vm_size| Specifies the [size of the Virtual Machine](https://docs.microsoft.com/azure/virtual-machines/sizes-general). See also [Azure VM Naming Conventions](https://docs.microsoft.com/azure/virtual-machines/vm-naming-conventions).||True|
|availability_set|The `availability_set` block as defined below.|Block|False|
|boot_diagnostics| A `boot_diagnostics` block as defined below.| Block |False|
|additional_capabilities| An `additional_capabilities` block as defined below.| Block |False|
|delete_os_disk_on_termination| Should the OS Disk (either the Managed Disk / VHD Blob) be deleted when the Virtual Machine is destroyed? Defaults to `false`.||False|
|delete_data_disks_on_termination| Should the Data Disks (either the Managed Disks / VHD Blobs) be deleted when the Virtual Machine is destroyed? Defaults to `false`.||False|
|identity| An `identity` block as defined below.| Block |False|
|license_type| Specifies the BYOL Type for this Virtual Machine. This is only applicable to Windows Virtual Machines. Possible values are `Windows_Client` and `Windows_Server`.||False|
|os_profile| An `os_profile` block as defined below. Required when `create_option` in the `storage_os_disk` block is set to `FromImage`.| Block |False|
|os_profile_secrets| One or more `os_profile_secrets` blocks.| Block |False|
|plan| A `plan` block as defined below.| Block |False|
|primary_network_interface_id| The ID of the Network Interface (which must be attached to the Virtual Machine) which should be the Primary Network Interface for this Virtual Machine.||False|
|proximity_placement_group|The `proximity_placement_group` block as defined below.|Block|False|
|storage_data_disk| One or more `storage_data_disk` blocks.| Block |False|
|storage_image_reference| A `storage_image_reference` block as defined below.| Block |False|
|storage_os_disk| A `storage_os_disk` block as defined below.| Block |True|
|tags| A mapping of tags to assign to the Virtual Machine.||False|
|zones| A list of a single item of the Availability Zone which the Virtual Machine should be allocated in.||False|
|pass| Specifies the name of the pass that the content applies to. The only allowable value is `oobeSystem`.||True|
|component| Specifies the name of the component to configure with the added content. The only allowable value is `Microsoft-Windows-Shell-Setup`.||True|
|setting_name| Specifies the name of the setting to which the content applies. Possible values are: `FirstLogonCommands` and `AutoLogon`.||True|
|content| Specifies the base-64 encoded XML formatted content that is added to the unattend.xml file for the specified path and component.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|os_profile_linux_config|disable_password_authentication| Specifies whether password authentication should be disabled. If set to `false`, an `admin_password` must be specified.|||True|
|os_profile_linux_config|ssh_keys| One or more `ssh_keys` blocks. This field is required if `disable_password_authentication` is set to `true`.|||False|
|ssh_keys|key_data| The Public SSH Key which should be written to the `path` defined above.|||True|
|ssh_keys|path| The path of the destination file on the virtual machine|||True|
|os_profile_windows_config|provision_vm_agent| Should the Azure Virtual Machine Guest Agent be installed on this Virtual Machine? Defaults to `false`.|||False|
|os_profile_windows_config|enable_automatic_upgrades| Are automatic updates enabled on this Virtual Machine? Defaults to `false.`|||False|
|os_profile_windows_config|timezone| Specifies the time zone of the virtual machine, [the possible values are defined here](http://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/).|||False|
|os_profile_windows_config|winrm| One or more `winrm` blocks as defined below.|||False|
|winrm|protocol| Specifies the protocol of listener. Possible values are `HTTP` or `HTTPS`.|||True|
|winrm|certificate_url| The ID of the Key Vault Secret which contains the encrypted Certificate which should be installed on the Virtual Machine. This certificate must also be specified in the `vault_certificates` block within the `os_profile_secrets` block.|||False|
|os_profile_windows_config|additional_unattend_config| An `additional_unattend_config` block as defined below.|||False|
|additional_unattend_config|pass| Specifies the name of the pass that the content applies to. The only allowable value is `oobeSystem`.|||True|
|additional_unattend_config|component| Specifies the name of the component to configure with the added content. The only allowable value is `Microsoft-Windows-Shell-Setup`.|||True|
|additional_unattend_config|setting_name| Specifies the name of the setting to which the content applies. Possible values are: `FirstLogonCommands` and `AutoLogon`.|||True|
|additional_unattend_config|content| Specifies the base-64 encoded XML formatted content that is added to the unattend.xml file for the specified path and component.|||False|
|availability_set| key | Key for  availability_set||| Required if  |
|availability_set| lz_key |Landing Zone Key in wich the availability_set is located|||False|
|availability_set| id | The id of the availability_set |||False|
|boot_diagnostics|enabled| Should Boot Diagnostics be enabled for this Virtual Machine?|||True|
|boot_diagnostics|storage_uri| The Storage Account's Blob Endpoint which should hold the virtual machine's diagnostic files.|||True|
|additional_capabilities|ultra_ssd_enabled| Should Ultra SSD disk be enabled for this Virtual Machine?|||True|
|identity|type| The Managed Service Identity Type of this Virtual Machine. Possible values are `SystemAssigned` (where Azure will generate a Service Principal for you), `UserAssigned` (where you can specify the Service Principal ID's) to be used by this Virtual Machine using the `identity_ids` field, and `SystemAssigned, UserAssigned` which assigns both a system managed identity as well as the specified user assigned identities.|||True|
|identity|identity_ids| Specifies a list of user managed identity ids to be assigned to the VM. Required if `type` is `UserAssigned`.|||False|
|os_profile|computer_name| Specifies the name of the Virtual Machine.|||True|
|os_profile|admin_username| Specifies the name of the local administrator account.|||True|
|os_profile|admin_password| The password associated with the local administrator account.|||False|
|os_profile|admin_password| The password associated with the local administrator account.|||False|
|os_profile|custom_data| Specifies custom data to supply to the machine. On Linux-based systems, this can be used as a cloud-init script. On other systems, this will be copied as a file on disk. Internally, Terraform will base64 encode this value before sending it to the API. The maximum length of the binary array is 65535 bytes.|||False|
|os_profile_secrets|source_vault_id| Specifies the ID of the Key Vault to use.|||True|
|os_profile_secrets|vault_certificates| One or more `vault_certificates` blocks.|||True|
|vault_certificates|certificate_url| The ID of the Key Vault Secret. Stored secret is the Base64 encoding of a JSON Object that which is encoded in UTF-8 of which the contents need to be:|||True|
|vault_certificates|certificate_store| Specifies the certificate store on the Virtual Machine where the certificate should be added to, such as `My`.|||False|
|plan|name| Specifies the name of the image from the marketplace.|||True|
|plan|publisher| Specifies the publisher of the image.|||True|
|plan|product| Specifies the product of the image from the marketplace.|||True|
|proximity_placement_group| key | Key for  proximity_placement_group||| Required if  |
|proximity_placement_group| lz_key |Landing Zone Key in wich the proximity_placement_group is located|||False|
|proximity_placement_group| id | The id of the proximity_placement_group |||False|
|storage_data_disk|name| The name of the Data Disk.|||True|
|storage_data_disk|caching| Specifies the caching requirements for the Data Disk. Possible values include `None`, `ReadOnly` and `ReadWrite`.|||False|
|storage_data_disk|create_option| Specifies how the data disk should be created. Possible values are `Attach`, `FromImage` and `Empty`.|||True|
|storage_data_disk|disk_size_gb| Specifies the size of the data disk in gigabytes.|||False|
|storage_data_disk|lun| Specifies the logical unit number of the data disk. This needs to be unique within all the Data Disks on the Virtual Machine.|||True|
|storage_data_disk|write_accelerator_enabled| Specifies if Write Accelerator is enabled on the disk. This can only be enabled on `Premium_LRS` managed disks with no caching and [M-Series VMs](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/how-to-enable-write-accelerator). Defaults to `false`.|||False|
|storage_data_disk|managed_disk_type| Specifies the type of managed disk to create. Possible values are either `Standard_LRS`, `StandardSSD_LRS`, `Premium_LRS` or `UltraSSD_LRS`.|||False|
|storage_data_disk|managed_disk_id| Specifies the ID of an Existing Managed Disk which should be attached to this Virtual Machine. When this field is set `create_option` must be set to `Attach`.|||False|
|storage_data_disk|vhd_uri| Specifies the URI of the VHD file backing this Unmanaged Data Disk. Changing this forces a new resource to be created.|||False|
|storage_image_reference|publisher| Specifies the publisher of the image used to create the virtual machine. Changing this forces a new resource to be created.|||True|
|storage_image_reference|offer| Specifies the offer of the image used to create the virtual machine. Changing this forces a new resource to be created.|||True|
|storage_image_reference|sku| Specifies the SKU of the image used to create the virtual machine. Changing this forces a new resource to be created.|||True|
|storage_image_reference|version| Specifies the version of the image used to create the virtual machine. Changing this forces a new resource to be created.|||False|
|storage_image_reference|id| Specifies the ID of the Custom Image which the Virtual Machine should be created from. Changing this forces a new resource to be created.|||True|
|storage_os_disk|name| Specifies the name of the OS Disk.|||True|
|storage_os_disk|create_option| Specifies how the OS Disk should be created. Possible values are `Attach` (managed disks only) and `FromImage`.|||True|
|storage_os_disk|caching| Specifies the caching requirements for the OS Disk. Possible values include `None`, `ReadOnly` and `ReadWrite`.|||False|
|storage_os_disk|disk_size_gb| Specifies the size of the OS Disk in gigabytes.|||False|
|storage_os_disk|image_uri| Specifies the Image URI in the format `publisherName:offer:skus:version`. This field can also specify the [VHD uri](https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-linux-cli-deploy-templates/#create-a-custom-vm-image) of a custom VM image to clone. When cloning a Custom (Unmanaged) Disk Image the `os_type` field must be set.|||False|
|storage_os_disk|os_type| Specifies the Operating System on the OS Disk. Possible values are `Linux` and `Windows`.|||False|
|storage_os_disk|write_accelerator_enabled| Specifies if Write Accelerator is enabled on the disk. This can only be enabled on `Premium_LRS` managed disks with no caching and [M-Series VMs](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/how-to-enable-write-accelerator). Defaults to `false`.|||False|
|storage_os_disk|managed_disk_id| Specifies the ID of an existing Managed Disk which should be attached as the OS Disk of this Virtual Machine. If this is set then the `create_option` must be set to `Attach`.|||False|
|storage_os_disk|managed_disk_type| Specifies the type of Managed Disk which should be created. Possible values are `Standard_LRS`, `StandardSSD_LRS` or `Premium_LRS`.|||False|
|storage_os_disk|vhd_uri| Specifies the URI of the VHD file backing this Unmanaged OS Disk. Changing this forces a new resource to be created.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Virtual Machine.|||
|identity|An `identity` block as defined below, which contains the Managed Service Identity information for this Virtual Machine.|||
