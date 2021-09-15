global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
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
    name               = "example"
    resource_group_key = "rg1"
  }
}

storage_accounts = {
  sa1 = {
    name                     = "sa1dev"
    resource_group_key       = "rg1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    containers = {
      dev = {
        name = "foo"
      }
    }
  }
}


data_factory_linked_service_azure_blob_storage = {
  dflsabs1 = {
    name                = "dflsabs1example"
    resource_group_key  = "rg1"
    data_factory_key    = "df1"
    connection_string   = "aaaa"
    storage_account_key = "sa1"
  }
}

data_factory_dataset_azure_blob = {
  dfdab1 = {
    name               = "dfdab1example"
    resource_group_key = "rg1"
    data_factory_key   = "df1"
    linked_service_key = "dflsabs1"

    path     = "foo"
    filename = "bar.png"
  }
}

