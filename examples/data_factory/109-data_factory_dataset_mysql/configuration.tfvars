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
data_factory_linked_service_mysql = {
  dflsmysql1 = {
    name               = "dflsabs1example"
    resource_group_key = "rg1"
    data_factory_key   = "df1"
    connection_string  = "Server=test;Port=3306;Database=test;User=test;SSLMode=1;UseSystemTrustStore=0;Password=test"
  }
}

data_factory_dataset_mysql = {
  dfdab1 = {
    name               = "dfdab1example"
    resource_group_key = "rg1"
    data_factory_key   = "df1"
    linked_service_key = "dflsmysql1"
  }
}

