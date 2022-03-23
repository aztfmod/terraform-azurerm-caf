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

data_factory_integration_runtime_azure_ssis = {
  dfiras1 = {
    name = "dfiras1"
    data_factory = {
      key = "df1"
    }
    resource_group = {
      key = "rg1"
    }
    region = "region1"

    node_size = "Standard_D8_v3"
  }
}