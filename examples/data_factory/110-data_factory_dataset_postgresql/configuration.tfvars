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

data_factory_linked_service_postgresql = {
  dflspsql1 = {
    name               = "dflspsql1example"
    resource_group_key = "rg1"
    data_factory_key   = "df1"
    connection_string  = "Host=example;Port=5432;Database=example;UID=example;EncryptionMethod=0;Password=example"
  }
}

data_factory_dataset_postgresql = {
  dfdpsql1 = {
    name               = "dfdpsql1example"
    resource_group_key = "rg1"
    data_factory_key   = "df1"
    linked_service_key = "dflspsql1"
  }
}

