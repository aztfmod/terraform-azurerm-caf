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

data_factory_linked_service_sql_server = {
  dflsabs1 = {
    name               = "dflsabs1example"
    resource_group_key = "rg1"
    data_factory_key   = "df1"
    connection_string  = "Integrated Security=False;Data Source=test;Initial Catalog=test;User ID=test;Password=test"
  }
}

data_factory_dataset_sql_server_table = {
  dfdab1 = {
    name               = "dfdab1example"
    resource_group_key = "rg1"
    data_factory_key   = "df1"
    linked_service_key = "dflsabs1"
  }
}

