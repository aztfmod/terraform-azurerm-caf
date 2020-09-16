global_settings = {
  prefix           = "dsde"
  default_location = "southeastasia"
  environment      = "demo"
}

resource_groups = {
  security = {
    name      = "launchpad-security"
    useprefix = true
  }
}


keyvaults = {
  launchpad = {
    name               = "launchpad"
    resource_group_key = "security"
    region             = "southeastasia"
    sku_name           = "standard"
    tags = {
      environment = "demo"
      tfstate     = "level0"
    }
  }
}


## Networking configuration
networking = {
  hub_sg = {
    resource_group_key = "vnet_sg"
    location           = "southeastasia"
    vnet = {
      name          = "hub"
      address_space = ["10.10.100.0/24"]
    }
    specialsubnets = {
    }
    subnets = {
      jumpbox = {
        name     = "jumpbox"
        cidr     = ["10.10.100.0/25"]
        nsg_name = "jumpbox_nsg"
        nsg      = []
      }

    }
    diags = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["VMProtectionAlerts", true, true, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, true, 7],
      ]
    }
  }

}