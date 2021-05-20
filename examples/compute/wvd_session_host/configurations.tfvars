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

wvd_session_hosts = {
  wvd_sh1 = {
    resource_group_key = "wvd_region1"
    name               = "armsession1"
    wvd_host_pool_key  = "wvd_hp1"
    lz_key             = "examples"
    # hostpool = {
    #   wvd_host_pool_key  = "wvd_hp1"
    #   lz_key       = "examples"
    # }
    administrator = {
      keyvault_key = "wvd_kv1"
      lz_key       = "examples"
    }
    vmadministrator = {
      keyvault_key = "wvd_kv2"
      lz_key       = "examples"
    }
    hostpoolToken = {
      keyvault_key = "wvd_kv3"
      lz_key       = "examples"
    }

    vmTemplate                       = ""
    administratorAccountUsername     = "adminuser@contoso.com"
    vmAdministratorAccountUsername   = "vmadmin-username"
    availabilityOption               = "AvailabilitySet"
    availabilitySetName              = "arm-avset8"
    createAvailabilitySet            = true
    availabilitySetUpdateDomainCount = 5
    availabilitySetFaultDomainCount  = 2
    availabilityZone                 = 2
    vmSize                           = "Standard_F2s_v2"
    vmInitialNumber                  = 1
    vmNumberOfInstances              = 1
    vmNamePrefix                     = "armvm1"
    vmImageType                      = "Gallery"
    vmGalleryImageOffer              = "WindowsServer"
    vmGalleryImagePublisher          = "MicrosoftWindowsServer"
    vmGalleryImageSKU                = "2019-Datacenter"
    vmImageVhdUri                    = ""
    vmCustomImageSourceId            = ""
    vmDiskType                       = "StandardSSD_LRS"
    vmUseManagedDisks                = true
    storageAccountResourceGroupName  = ""
    vnet_key                         = "vnet_region1"
    subnet_key                       = "example"
    createNetworkSecurityGroup       = false
    networkSecurityGroupId           = ""
    networkSecurityGroupRules        = []
    availabilitySetTags              = {}
    networkInterfaceTags             = {}
    networkSecurityGroupTags         = {}
    virtualMachineTags               = {}
    imageTags                        = {}
    deploymentId                     = ""
    apiVersion                       = "2019-12-10-preview"
    ouPath                           = ""
    domain                           = "contoso.com"
    aadJoin                          = false
    intune                           = false

  }
}

# ## Networking configuration
vnets = {
  vnet_region1 = {
    resource_group_key = "wvd_region1"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.101.0/24"]
      dns_servers   = ["10.100.100.4"]
    }
    specialsubnets = {}

    subnets = {
      example = {
        name = "examples"
        cidr = ["10.100.101.0/25"]
        # nsg_key = "azure_wvd_nsg"
      }

    }

  }
}

# network_security_group_definition = {
#   # This entry is applied to all subnets with no NSG defined
#   empty_nsg = {}  
#   azure_wvd_nsg = {

#     nsg = [
#       {
#         name                       = "web-in-allow",
#         priority                   = "100"
#         direction                  = "Inbound"
#         access                     = "Allow"
#         protocol                   = "tcp"
#         source_port_range          = "*"
#         destination_port_range     = "443"
#         source_address_prefix      = "*"
#         destination_address_prefix = "*"
#       },      
#       {
#         name                       = "web-out-allow",
#         priority                   = "120"
#         direction                  = "Outbound"
#         access                     = "Allow"
#         protocol                   = "tcp"
#         source_port_range          = "*"
#         destination_port_range     = "443"
#         source_address_prefix      = "*"
#         destination_address_prefix = "AzureCloud"
#       }
#     ]
#   }
# }

