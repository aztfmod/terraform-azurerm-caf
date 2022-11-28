cdn_profile = {
  example_profile = {
    name = "exampleprofile"
    resource_group = {
      key = "cdn_profile_example_key"
    }
    region = "region1"
    sku    = "Standard_Microsoft"
  }
}

cdn_endpoint = {
  example_endpoint = {
    name   = "exampleendpoint"
    region = "region1"
    resource_group = {
      key = "cdn_profile_example_key"
    }
    profile = {
      key = "example_profile"
    }
    origin = {
      name      = "example"
      host_name = "www.contoso.com"
    }
    storage_account_key = "example_storage_account_key"
  }
}