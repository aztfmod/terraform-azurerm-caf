# Create log analytics workspace with Updates solution and linked automation account
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  automation = {
    name = "automation"
  }
}

automations = {
  auto1 = {
    name               = "automation"
    sku                = "Basic"
    resource_group_key = "automation"

    identity = {
      type = "SystemAssigned"
      #managed_identity_keys = ["mi1"]
    }
  }
}

managed_identities = {
  mi1 = {
    name = "automation-msi"
    resource_group = {
      key = "automation"
    }
  }
}
