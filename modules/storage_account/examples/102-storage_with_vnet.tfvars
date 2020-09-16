resource_groups = {
  test_sg = {
    name      = "test-caf_storage_account-sg"
    location  = "southeastasia"
    useprefix = true
  }
  vnet_sg = {
    name      = "test-networking-sg"
    location  = "southeastasia"
    useprefix = true
  }
}

storage_accounts = {
  media = {
    name               = "media"
    resource_group_key = "test_sg"
    network_rules = {
      default_action = "Allow"
      bypass         = "Logging"
      vnet_key       = "hub_sg"
      subnet_key     = "jumpbox"
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