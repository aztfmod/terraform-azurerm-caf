global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  sb_examples = {
    name   = "servicebus"
    region = "region1"
  }
}

service_bus_namespaces = {
  sb_ns1 = {
    name               = "sb_ns1"
    resource_group_key = "sb_examples"
    sku                = "Standard"
    region             = "region1"
    capacity           = 1    # Optional: capacity attribute can only be used with Premium sku. Possible values 1,2,4,8 or 16
    zone_redundant     = true # Optional: zone_redundant attribute can only be used with Premium sku. Defaults to false
    tags = {
      "environment" = "Dev"
    }
  }
}