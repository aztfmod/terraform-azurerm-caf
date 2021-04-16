global_settings = {
  default_region = "region1"
  regions = {
    region1 = "East US"
    region2 = "southeastasia"
    
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  wvd_region1 = {
    name = "wvd"
  }
  
}

landingzone = {  
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "wvd_post"
  tfstates = {
    examples = {
      tfstate = "wvd-pre.tfstate"
    }
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
  }  
}

wvd_application_groups = {
  wvd_app1 = {
    resource_group_key  = "wvd_region1"
    host_pool_key       = "wvd_hp1"
    wvd_workspace_key   = "wvd_ws1"
    name                = "firstapp"
    friendly_name       = "Myappgroup"
    description         = "A description of my workspace"
    #Type of Virtual Desktop Application Group. Valid options are RemoteApp or Desktop.
    type          = "Desktop"
    
  }

  wvd_app2 = {
    resource_group_key  = "wvd_region1"
    host_pool_key       = "wvd_hp1"
    wvd_workspace_key   = "wvd_ws1"
    name                = "firstremoteapp"
    friendly_name       = "Myremoteappgroup"
    description         = "A description of my workspace"
    #Type of Virtual Desktop Application Group. Valid options are RemoteApp or Desktop.
    type          = "RemoteApp"
    
  }
}

wvd_host_pools = {
  wvd_hp1 = {
    resource_group_key   = "wvd_region1"
    name                 = "armhp"
    friendly_name        = "Myhostpool"
    description          = "A description of my workspace"
    validate_environment = false
    type                 = "Pooled"
    #Option to specify the preferred Application Group type for the Virtual Desktop Host Pool. Valid options are None, Desktop or RailApplications.
    preferred_app_group_type = "Desktop"
    maximum_sessions_allowed = 1000
    load_balancer_type       = "DepthFirst"
    #Expiration value should be between 1 hour and 30 days.
    registration_info = {
      expiration_date = "2021-05-12T07:20:50Z"
    }
  }

  wvd_hp2 = {
    resource_group_key   = "wvd_region1"
    name                 = "armremotehp"
    friendly_name        = "Myremotehostpool"
    description          = "A description of my workspace"
    validate_environment = false
    type                 = "Pooled"
    #Option to specify the preferred Application Group type for the Virtual Desktop Host Pool. Valid options are None, Desktop or RailApplications.
    preferred_app_group_type = "RailApplications"
    maximum_sessions_allowed = 1000
    load_balancer_type       = "DepthFirst"
    #Expiration value should be between 1 hour and 30 days.
    registration_info = {
      expiration_date = "2021-05-12T07:20:50Z"
    }
  }
}

wvd_workspaces = {

  wvd_ws1 = {
    resource_group_key  = "wvd_region1"
    name                = "myws"
    friendly_name       = "Myworkspace"
    description         = "A description of my workspace"
  }
}

wvd_session_hosts = {
  wvd_sh1 = {
    resource_group_key  = "wvd_region1"
    name                = "armsession16"
    wvd_host_pool_key   =  "wvd_hp1"
    keyvault_key        = "wvd_kv" 
    lz_key = "examples"
    vmadministrator = {
      keyvault_key        = "wvd_kv2"
      lz_key = "examples"
    }
    administrator = {
      keyvault_key        = "wvd_kv1"
      lz_key = "examples"
    }
    hostpoolToken = {
      keyvault_key        = "wvd_kv3"
      lz_key = "examples"

    }

    hostpoolProperties = {}    
    vmTemplate = ""
    administratorAccountUsername = "wvduser@test.onmicrosoft.com"
    vmAdministratorAccountUsername = "vmadmin-username"
    availabilityOption = "AvailabilitySet"
    availabilitySetName = "arm-avset8"
    createAvailabilitySet = true
    availabilitySetUpdateDomainCount = 5
    availabilitySetFaultDomainCount = 2
    availabilityZone = 2
    vmSize = "Standard_F2s_v2"
    vmInitialNumber = 1
    vmNumberOfInstances = 1
    vmNamePrefix = "armvm16"
    vmImageType = "Gallery"
    vmGalleryImageOffer = "WindowsServer"
    vmGalleryImagePublisher = "MicrosoftWindowsServer"
    vmGalleryImageSKU = "2019-Datacenter"
    vmImageVhdUri = ""
    vmCustomImageSourceId = ""
    vmDiskType = "StandardSSD_LRS"
    vmUseManagedDisks = true
    storageAccountResourceGroupName = ""
    existingVnetName = "xxx-vnet-virtual_machines"
    # vnet_key = "vnet_region1"
    existingSubnetName = "xxx-snet-examples"
    createNetworkSecurityGroup = false
    networkSecurityGroupId = ""
    networkSecurityGroupRules = []
    availabilitySetTags = {}
    networkInterfaceTags = {}
    networkSecurityGroupTags = {}
    virtualMachineTags = {}
    imageTags = {}
    deploymentId = ""
    apiVersion = "2019-12-10-preview"
    ouPath = ""
    domain = "test.onmicrosoft.com "
    aadJoin = true
    intune = false      
    
  }
}

# ## Networking configuration
vnets = {
  vnet_region1 = {
    resource_group_key = "wvd_region1"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.100.0/24"]
      dns_servers = ["10.1.0.4", "10.1.0.5"]
    }
    specialsubnets = {}
    
    subnets = {
      example = {
        name = "examples"
        cidr = ["10.100.100.0/25"]
        nsg_key = "azure_wvd_nsg"
      }
      
    }

  }
}

network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {}  
  azure_wvd_nsg = {

    nsg = [
      {
        name                       = "web-in-allow",
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },      
      {
        name                       = "web-out-allow",
        priority                   = "120"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
      }
    ]
  }
}


keyvaults = {
  wvd_kv = {
    name                = "testkv"
    resource_group_key  = "wvd_region1"
    sku_name            = "standard"
    soft_delete_enabled = true
    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }

  wvd_kv1 = {
    name                = "testkv1"
    resource_group_key  = "wvd_region1"
    sku_name            = "standard"
    soft_delete_enabled = true
    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }

  wvd_kv2 = {
    name                = "testkv2"
    resource_group_key  = "wvd_region1"
    sku_name            = "standard"
    soft_delete_enabled = true
    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
  
}


dynamic_keyvault_secrets = {
  wvd_kv = { # Key of the keyvault    
    domain-password = {
      secret_name = "newwvd-admin-password"
      value       = ""  #Insert manually 
    }    
  }

  wvd_kv1 = { # Key of the keyvault    
    vm-password = {
      secret_name = "newwvd-vm-password"
      value       = ""  #Insert manually 
    }
    
  }

  wvd_kv2 = { # Key of the keyvault    
    hostpool-token = {
      secret_name = "newwvd-hostpool-token"
      value       = ""  #Insert manually 
    }
  }  
  
}




