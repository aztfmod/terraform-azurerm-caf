global_settings = {
  default_region = "region1"
  environment    = "test"
  regions = {
    region1 = "eastus"
    region2 = "centralus"
    region3 = "westeurope"
  }
}

resource_groups = {
  managed_disks_region1 = {
    name = "managed-disks"
  }
}

managed_disks = {
  disk1 = {
    name                 = "server1-data1"
    storage_account_type = "Standard_LRS"
    create_option        = "Empty"
    disk_size_gb         = "10"
    zones                = ["1"]
    resource_group_key   = "managed_disks_region1"
  }
}
