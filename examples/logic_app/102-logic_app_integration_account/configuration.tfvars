global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
}

resource_groups = {
  rglaia1 = {
    name   = "exampleRG1"
    region = "region1"
  }
}

logic_app_integration_account = {
  laia1 = {
    name               = "example-ia"
    region             = "region1"
    resource_group_key = "rglaia1"
    sku_name           = "Standard"
  }
}