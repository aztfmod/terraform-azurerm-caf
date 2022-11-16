global_settings = {
  default_region = "region1"
  environment    = "test"
  regions = {
    region1 = "australiaeast"
    region2 = "australiacentral"
    region3 = "westeurope"
  }
}


resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  acr_region1 = {
    name = "acr"
  }
}

azure_container_registries = {
  acr1 = {
    name               = "acr-test"
    resource_group_key = "acr_region1"
    sku                = "Premium"
    # georeplications = {
    #   region2 = {
    #     tags = {
    #       region = "australiacentral"
    #       type   = "acr_replica"
    #     }
    #   }
    #   region3 = {
    #     tags = {
    #       region = "westeurope"
    #       type   = "acr_replica"
    #     }
    #   }
    # }
  }
}

