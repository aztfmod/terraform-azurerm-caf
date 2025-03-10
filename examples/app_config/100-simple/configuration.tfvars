global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
}

provider_azurerm_features_template_deployment = {
  delete_nested_items_during_deletion = true
}

resource_groups = {
  rg1 = {
    name   = "rg1"
    region = "region1"
  }
}

app_config = {
  appconf1 = {
    name               = "appConf1"
    resource_group_key = "rg1"
    location           = "region1"
    tags = {
      project = "sales"
    }

    # sample fixed key value pairs
    settings = {
      "key" = "value"
    }

    # sample dynamic key value pair vault_uri for keyvault <key_vault_key> in state <landing_zone_key>
    # possible other resources are listed in definition of 'dynamic_app_config_combined_objects' in locals.tf (https://github.com/aztfmod/terraform-azurerm-caf/blob/5b85b6e8bd7283788f3c3bb37e7e0b7cff40e7fd/locals.tf#L209) 
    # dynamic_settings = {
    #   "dynamickey" = {
    #     keyvaults = {
    #       "<key_vault_key>" = {
    #         lz_key = "<landing_zone_key>"
    #         attribute_key = "vault_uri"
    #       }
    #     }
    #   }
    # }
  }
}