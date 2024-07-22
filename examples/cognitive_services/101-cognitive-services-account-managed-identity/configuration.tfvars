global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
  random_length = 5
}

resource_groups = {
  test-rg = {
    name = "rg-cognitive-test"
  }
}

managed_identities = {
  cognitive_msi = {
    name               = "cognitive-msi"
    resource_group_key = "test-rg"
  }
}

cognitive_services_account = {
  test_account-1 = {
    resource_group = {
      # accepts either id or key to get resource group id
      # id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup1"
      # lz_key = "examples"
      key = "test-rg"
    }
    name     = "cs-test-1"
    kind     = "OpenAI"
    sku_name = "S0"
    public_network_access_enabled = true

    identity = {
      type = "SystemAssigned, UserAssigned" // Can be "SystemAssigned, UserAssigned" or "SystemAssigned" or "UserAssigned"
      key  = "cognitive_msi" // A must with "SystemAssigned, UserAssigned" and "UserAssigned"
    }

    tags = {
      env = "test"
    }
    # custom_subdomain_name = "cs-test-1"
    # network_acls = {
    #   default_action = "Allow"
    #   ip_rules       = ["10.10.10.0/16"]
    # }
  }
  test_account-2 = {
    resource_group = {
      # accepts either id or key to get resource group id
      # id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup1"
      # lz_key = "examples"
      key = "test-rg"
    }
    name     = "cs-test-2"
    kind     = "QnAMaker"
    sku_name = "F0"

    identity = {
      type = "SystemAssigned"
    }

    tags = {
      env = "test"
    }
    qna_runtime_endpoint = "https://cs-alz-caf-test-2.azurewebsites.net"

  }
}

