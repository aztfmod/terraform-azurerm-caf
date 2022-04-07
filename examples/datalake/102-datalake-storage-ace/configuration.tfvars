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

azuread_groups = {
  ad_group1 = {
    name        = "example-group1"
    description = "Provide read and write access"
    members = {
      user_principal_names = []
      group_names          = []
      object_ids           = []
      group_keys           = []

      service_principal_keys = []

    }
    owners = {
      user_principal_names = []
    }
    prevent_duplicate_name = false
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
        ace = [
          {
            ad_group_key = "ad_group1"
            scope        = "access"
            type         = "group"
            perm         = "rwx"
          },
          {
            id           = "e329857c-aae4-4682-bdb8-d0126727498c"
            scope        = "default"
            type         = "group"
            perm         = "rwx"
          }
        ]
      }
    }

  }
}
