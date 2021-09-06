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
data_factory_pipeline = {
  dfp1 = {
    name               = "example"
    resource_group_key = "rg1"
    data_factory_key   = "df1"
  }
}