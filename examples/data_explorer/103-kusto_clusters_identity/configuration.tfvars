global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
}
resource_groups = {
  rg1 = {
    name   = "dedicated-test"
    region = "region1"
  }
}

# azurerm_routes = {
#   no_internet = {
#     name               = "no_internet"
#     resource_group_key = "network"
#     route_table_key    = "no_internet"
#     address_prefix     = "0.0.0.0/0"
#     next_hop_type      = "None"
#   }
# }
managed_identities = {
  mid1 = {
    name               = "mid1"
    resource_group_key = "rg1"
  }
}
kusto_clusters = {
  kc1 = {
    name = "kustocluster"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name   = ""
    }
    region = "region1"

    sku = {
      name     = "Dev(No SLA)_Standard_E2a_v4"
      capacity = 1
    }
    identity = {
      type = "UserAssigned" // Possible options are 'SystemAssigned, UserAssigned' 'SystemAssigned' or 'UserAssigned'
      managed_identity_keys = [
        "mid1"
      ]
    } // identity
  }
}