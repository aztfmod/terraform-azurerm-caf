global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}


resource_groups = {
  dap_synapse_re1 = {
    name = "dap_synapse_re1"
  }
}


storage_accounts = {
  amlstorage_re1 = {
    name                     = "amlre1"
    resource_group_key       = "dap_synapse_re1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Hot"
  }
  synapsestorage_re1 = {
    name                     = "synapsere1"
    resource_group_key       = "dap_synapse_re1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Hot"
    is_hns_enabled           = true

    data_lake_filesystems = {
      mlfilesystem = {
        name = "mlfilesystem"
        properties = {
          dap = "200-basic-ml"
        }
      }
    }

  }
}
