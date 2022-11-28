global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}
resource_groups = {
  rg1 = {
    name   = "databricks-re1"
    region = "region1"
  }
}
data_factory = {
  df1 = {
    name = "example"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }
  }
}

storage_accounts = {
  sa1 = {
    name = "sa1dev"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }
    #account_kind             = "BlobStorage"
    #account_tier             = "Standard"
    #account_replication_type = "LRS"
    containers = {
      foo = {
        name = "foo"
      }
    }
  }
}


data_factory_linked_service_azure_blob_storage = {
  dflsabs1 = {
    name = "dflsabs1example"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }
    data_factory = {
      key = "df1"
      #lz_key = ""
      #name = ""
    }
    storage_account = {
      key = "sa1"
      #lz_key = ""
      #connection_string = ""
    }
  }
}

data_factory_dataset_azure_blob = {
  dfdab1 = {
    name = "dfdab1example"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }
    data_factory = {
      key = "df1"
      #lz_key = ""
      #name = ""
    }
    linked_service = {
      key = "dflsabs1"
      #lz_key = ""
      #name = ""
    }

    path     = "foo"
    filename = "bar.png"
  }
}