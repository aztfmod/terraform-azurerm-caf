global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
  random_length = 5
}

resource_groups = {
  test-rg = {
    name = "rg-alz-caf-test-1"
  }
}

api_management = {
  test-account-1 = {
    resource_group = {
      # accepts either id or key to get resource group id
      # id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup1"
      # lz_key = "examples"
      key = "test-rg"
    }
    name = "example-apim"
    publisher_name      = "My Company"
    publisher_email     = "company@terraform.io"
    sku_name = "Developer_1"
  }

}
