cdn_profiles = {
  example_profile = {
    name               = "exampleprofile"
    resource_group_key = "cdn_profile_example_key"
    location           = "global"
    sku                = "Standard_Microsoft"
  }
}

cdn_endpoints = {
  example_endpoint = {
    name                = "exampleendpoint"
    profile_name        = "exampleprofile"
    origin_name         = "exampleendpoint"
    storage_account_key = "example_storage_account_key"
  }
}