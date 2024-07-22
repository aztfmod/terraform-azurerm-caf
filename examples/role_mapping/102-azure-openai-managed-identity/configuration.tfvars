global_settings = {
  default_region = "region1"
  regions = {
    region1 = "uksouth"
  }
}

resource_groups = {
  rg1 = {
    name = "example-msi-openai-rg1"
  }
}

cognitive_services_account = {
  primer = {
    resource_group = {
      key = "rg1"
    }
    name                  = "pinecone-llm-demoopenai"
    kind                  = "OpenAI"
    sku_name              = "S0"
    custom_subdomain_name = "cs-alz-caf-llm-demoopenai"
  }
}

managed_identities = {
  workload-msi = {
    name               = "example-msi-openai-rolemap-msi"
    resource_group_key = "rg1"
  }
}

role_mapping = {
  built_in_role_mapping = {
    cognitive_services_account = {
      primer = {
        "Cognitive Services User" = {
          managed_identities = {
            keys = ["workload-msi"]
          }
        }
      }
    }
  }
}