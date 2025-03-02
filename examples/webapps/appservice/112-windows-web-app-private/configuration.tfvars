global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  inherit_tags = true
  tags = {
    env = "to_be_set"
  }
}

resource_groups = {
  windows_webapp_private = {
    name   = "windows-webapp-private"
    region = "region1"
  }
}

# By default asp1 will inherit from the resource group location
app_service_plans = {
  asp1 = {
    resource_group_key = "windows_webapp_private"
    name               = "asp-simple"

    sku = {
      tier = "Standard"
      size = "S1"
    }
    tags = {
      env = "uat"
    }
  }
}


vnets = {
  demo_vnet = {
    resource_group_key = "windows_webapp_private"
    region             = "region1"
    vnet = {
      name          = "demo-vnet"
      address_space = ["10.0.0.0/8"]  
    }

    subnets = {
      demo_subnet = {
        name            = "demo-subnet"
        cidr            = ["10.0.1.0/24"] 
        #nsg_key         = ""  
        enforce_private_link_endpoint_network_policies = true
        delegation = {
          name               = "serverFarms"
          service_delegation = "Microsoft.Web/serverFarms"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/action"
          ]
        }
    }
  }
}


windows_web_apps = {
 windows_web_app_private = {
    name                 = "windows-web-app-private"
    resource_group_key   = "windows_webapp_private"
    app_service_plan_key = "asp1"

    settings = {
      https_only = "true"
      always_on  = "false"
      public_network_access_enabled = false
      virtual_network_subnet = {
        subnet_key = "demo_subnet"
        vnet_key   = "demo_vnet"
        #lz_key     = ""
      }
      site_config = {
        ftps_state      = "Disabled"
        always_on       = "false"
        
        application_stack = {
          current_stack = "dotnetcore"
          dotnet_core_version = "v4.0"
        }
        ip_restriction_default_action = "Deny"
        ip_restriction = [
          {
            name = "demo-iprestriction"
            priority  = "100"
            ip_address  = "192.168.1.0/24" 
            # virtual_network_subnet = {
            #     subnet_key = "demo_subnet"
            #     vnet_key   = "demo_vnet"
            #     lz_key     = ""
            # }
            action = "Allow"
          }
        ]
      }
    }
    app_settings = {
      example_setting = "example-setting"
    }
  }
}