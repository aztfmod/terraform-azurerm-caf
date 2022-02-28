# To deploy Secured Process should be followed like this;
# 1. vWAN 
# 2. vHUB
# 3. Convert vHUB into Secured vHUB by deploying Azure Firewall
# 4. Vnet Connection (this should be ongoing)
# 5. Route Tables (as Static Internet Egress Route will Demand vNET Connection ID)
# 6. Azure Firewall Policies

# It should be deployed after vHUB Deployed only
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
}

# Seperate Resource Group where Azure Firewall will be deployed into 
resource_groups = {
  hub_re1 = {
    name   = "vnet-hub-re1"
    region = "region1"
  }
}

# Landing TFVARs for Secured vHUB Coversion 
landingzone = {
  backend_type        = "azurerm"
  # Dependency to vHUB which needs to be coverted into secured vHUB
  global_settings_key = "connectivity_virtual_hub1"
  level               = "level2"
  key                 = "secazfw1"
  tfstates = {
    connectivity_virtual_hub1 = {
      level   = "current"
      tfstate = "connectivity_virtual_hub1.tfstate"
    }
  }
}

# Azure Firewall Deployed into vHUB to coverted into secured vHUB
azurerm_firewalls = {
  firewall1 = {
    name               = "test-firewall"
    sku_name           = "AZFW_Hub"
    sku_tier           = "Premium" # 'Standard' or 'Premium'
    resource_group_key = "hub_re1" # Firewall Resource Group
    vnet_key           = "vnet1" # vNET Key where vHUB is being deployed
    virtual_hub = {
      hub1 = {
        virtual_wan_key = "vwan_re1" # vWAN Remote Key 
        virtual_hub_key = "hub_re1" # vHUB Remote Key
        #virtual_hub_id = "Azure_resource_id"
        #lz_key = "lz_key"
        public_ip_count = 1
      }
    }
  }
}