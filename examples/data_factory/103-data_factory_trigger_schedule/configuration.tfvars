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
data_factory_trigger_schedule = {
  dfps1 = {
    name                      = "example"
    data_factory_key          = "df1"
    resource_group_key        = "rg1"
    data_factory_pipeline_key = "dfp1"

    interval  = 5
    frequency = "Day"
  }
}
