managed_disks = {
  disk1 = {
    name                 = "server1-data1"
    storage_account_type = "Standard_LRS"
    # Only Empty is supported. More community contributions required to cover other scenarios
    create_option = "Empty"
    disk_size_gb  = "10"
    zones         = ["1"]
    resource_group_key = "vm_region1"
  }
}
