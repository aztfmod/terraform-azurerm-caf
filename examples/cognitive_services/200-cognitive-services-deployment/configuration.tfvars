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

cognitive_services_account = {
  test_account-1 = {
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
    # you must first agree to the Responsible AI terms for that resource type in your Azure subscription. This is a legal agreement that must be accepted in the Azure Portal before you can proceed with deployment via Terraform.
    # https://learn.microsoft.com/en-us/legal/cognitive-services/openai/limited-access
    deployment = {
      gpt-35-turbo = {
        name = "gpt-35-turbo"
        model = {
          name    = "gpt-35-turbo"
          format  = "OpenAI"
          version = "0301"
        }
        scale = {
          type     = "Standard"
          capacity = 1
        }
      }
    }
  }
}
