global_settings = {
  default_region = "region1"
  environment    = "test"
  regions = {
    region1 = "East US"
    region2 = "australiaeast"
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  wvd_region1 = {
    name = "wvd-environment"
  }
  vm_region1 = {
    name = "wvd-virtualmachines"
    tags = {
      env = "standalone"
    }
  }
}
