# Best Practice To deploy Secured Virtual HUB (vHUB), End to End Process should follow sequence like this;
# 1. vWAN deployment (Ideally First Time Deployment only because Generally vWAN is single deployment per Over Enterprise Landing Zone)
# 2. vHUB deployment (Subsequent vHUB deployment can start process from step 2)
# 3. Firewall Policy Deployment (It can be idependent of vHUB/vWAN deployment also)
# 4. Convert vHUB into Secured vHUB by deploying Azure Firewall
# 5. Route Table Deployment (If using Internet Egress Control via Secured vHUB Firewall,
# Then it should deployed in sequence after Secured vHUB deployment) 


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

# Landing Zone TFVARs for Secured vHUB Coversion 
landingzone = {
  backend_type        = "azurerm"
  # Mapping of vHUB which needs to be converted into Secured vHUB
  global_settings_key = "connectivity_virtual_hub1"
  level               = "level2"
  key                 = "secazfw1"
  tfstates = {
  # Mapping of Remote TF State File for vHUB which needs to be converted into Secured vHUB
    connectivity_virtual_hub1 = {
      level   = "current"
      tfstate = "connectivity_virtual_hub1.tfstate"
    }
  # Mapping of Remote TF State File for Firewall Policy which needs to be deployed into Secured vHUB Azure Firewall
    firewallpolicy = {
      level   = "current"
      tfstate = "firewallpolicy.tfstate"
    }
  }
}

# Azure Firewall Deployement into vHUB to covert into secured vHUB
azurerm_firewalls = {
  firewall1 = {
    name                 = "test-firewall"
    sku_name             = "AZFW_Hub"
    sku_tier             = "Standard" # Standard, Premium
    firewall_policy_key  = "policy1" # Ensure Policy is of same SKU as Firewall
    region               = "region2"
    # Resource Group for Firewall should be in same deployment. 
    # Remote Resource Group Key from Remote TF State is not supported yet. 
    resource_group_key  = "firewall1" 
    virtual_hub = {
      hub1 = {
        virtual_hub_key = "hub1" # Virtual Hub Key from Remote TF State, which needs to be converted into Secured vHUB
        lz_key = "connectivity_virtual_hub1" # Landing Zone Key
        public_ip_count = 1 # Number of Public IPs to be created for Secured vHUB
      }
    }
  }
}