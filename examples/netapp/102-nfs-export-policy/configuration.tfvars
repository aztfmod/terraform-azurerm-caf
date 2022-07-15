# This example creates a NetApp NFSv3 volume and assigns an export policy for the volume.
# Please update the CIDR to match the allowed source addresses. Must be in valid CIDR format x.x.x.x/x

global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  netapp_rg1 = {
    name = "example-netapp-rg1"
  }
}

netapp_accounts = {
  account1 = {
    name               = "netapp-name2"
    resource_group_key = "netapp_rg1"
    tags = {
      example = "netapp"
    }
    pools = {
      pool1 = {
        name          = "pool1"
        service_level = "Standard"
        size_in_tb    = 4
        tags = {
          pool = "pool1"
        }
        volumes = {
          volume1 = {
            name = "volume1"
            # Must be unique to the subscription
            volume_path = "path"
            vnet_key    = "vnet_region1"
            subnet_key  = "netapp"
            # Default is NFSv3
            protocols = ["NFSv3"] #["CIFS", "NFSv3", "NFSv3"]
            # Minimum 100
            storage_quota_in_gb = "100"
            # To be defined
            export_policy_rule = {
              "rule1" = {
                rule_index        = 1
                allowed_clients   = ["0.0.0.0/0"]
                protocols_enabled = ["NFSv3"] #["CIFS", "NFSv3", "NFSv3"]
                unix_read_only    = false
                unix_read_write   = true
              }
              "rule2" = {
                rule_index        = 2
                allowed_clients   = ["10.0.0.0/8"]
                protocols_enabled = ["NFSv3"] #["CIFS", "NFSv3", "NFSv3"]
                unix_read_only    = false
                unix_read_write   = true
              }
              "rule3" = {
                rule_index          = 3
                allowed_clients     = ["192.168.0.0/16"]
                protocols_enabled   = ["NFSv3"] #["CIFS", "NFSv3", "NFSv3"]
                unix_read_only      = false     #Optional Parameter
                unix_read_write     = true      #Optional Parameter
                root_access_enabled = true      #Optional Parameter
              }
            }
            tags = {
              volume = "volume 1"
            }
          }
        }
      }
      pool2 = {
        name = "pool2"
      }
    }
  }
}

vnets = {
  vnet_region1 = {
    resource_group_key = "netapp_rg1"
    vnet = {
      name          = "vnetnetapp"
      address_space = ["10.100.100.0/24"]
    }
    subnets = {}

    specialsubnets = {
      netapp = {
        name = "netapp"
        cidr = ["10.100.100.0/29"]
        delegation = {
          name               = "netapp"
          service_delegation = "Microsoft.Netapp/volumes"
          actions = [
            "Microsoft.Network/networkinterfaces/*",
          "Microsoft.Network/virtualNetworks/subnets/join/action"]
        }
      }
    }
  }
}
