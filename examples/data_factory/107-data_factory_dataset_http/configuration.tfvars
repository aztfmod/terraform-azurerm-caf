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
data_factory_linked_service_web = {
  dflsw1 = {
    name                = "dflsabs1example"
    resource_group_key  = "rg1"
    data_factory_key    = "df1"
    authentication_type = "Anonymous"
  url = "https://www.bing.com" }
}
data_factory_dataset_http = {
  dfddt1 = {
    name               = "example"
    resource_group_key = "rg1"
    data_factory_key   = "df1"
    linked_service_key = "dflsw1"

    relative_url   = "http://www.bing.com"
    request_body   = "foo=bar"
    request_method = "POST"
  }
}