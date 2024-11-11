global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
  random_length = 5
  #pass_through = true
}

resource_groups = {
  test-rg = {
    name = "rg-alz-caf-test-1"
  }
}

cognitive_services_account = {
  openai_account-1 = {
    resource_group = {
      # accepts either id or key to get resource group id
      # id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup1"
      # lz_key = "examples"
      key = "test-rg"
    }
    name     = "cs-alz-caf-test-1"
    kind     = "OpenAI"
    sku_name = "S0"

    tags = {
      env = "test"
    }
    # custom_subdomain_name = "cs-alz-caf-test-1"
    # network_acls = {
    #   default_action = "Allow"
    #   ip_rules       = ["10.10.10.0/16"]
    # }
  }   
}
