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
  }
}