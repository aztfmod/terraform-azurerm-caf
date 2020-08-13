# Sample Cloud Adoption Framework foundations landing zone

## globalsettings
global_settings = {
  #specifies the set of locations you are going to use in this landing zone
  location_map = {
    southeastasia = "southeastasia"
    eastasia      = "eastasia"
  }

  #naming convention to be used as defined in naming convention module, accepted values are cafclassic, cafrandom, random, passthrough
  convention = "cafrandom"

  #Set of tags for core operations
  tags_hub = {
    owner          = "CAF"
    deploymentType = "Terraform"
    costCenter     = "1664"
    BusinessUnit   = "SHARED"
    DR             = "NON-DR-ENABLED"
  }
}

# Set of resource groups to land the foundations
resource_groups = {
  HUB-CORE-SEC_southeastasia = {
    name     = "hub-core-sec-sea"
    location = "southeastasia"
  }
  HUB-OPERATIONS_southeastasia = {
    name     = "hub-operations-sea"
    location = "southeastasia"
  }
  HUB-CORE-SEC_eastasia = {
    name     = "hub-core-sec-hk"
    location = "eastasia"
  }
  HUB-OPERATIONS_eastasia = {
    name     = "hub-operations-hk"
    location = "eastasia"
  }
}


# ## governance
# governance_settings = {
#   southeastasia = {
#     #current code supports only two levels of managemenr groups and one root
#     deploy_mgmt_groups = false
#     management_groups = {
#       root = {
#         name          = "caf-rootmgmtgroup"
#         subscriptions = []
#         #list your subscriptions ID in this field as ["GUID1", "GUID2"]
#         children = {
#           child1 = {
#             name          = "tree1child1"
#             subscriptions = []
#           }
#           child2 = {
#             name          = "tree1child2"
#             subscriptions = []
#           }
#           child3 = {
#             name          = "tree1child3"
#             subscriptions = []
#           }
#         }
#       }
#     }

#     policy_matrix = {
#       #autoenroll_asc          = true - to be implemented via builtin policies
#       autoenroll_monitor_vm = true
#       autoenroll_netwatcher = false

#       no_public_ip_spoke     = false
#       cant_create_ip_spoke   = false
#       managed_disks_only     = true
#       restrict_locations     = false
#       list_of_allowed_locs   = ["southeastasia", "eastasia"]
#       restrict_supported_svc = false
#       list_of_supported_svc  = ["Microsoft.Network/publicIPAddresses", "Microsoft.Compute/disks"]
#       msi_location           = "southeastasia"
#     }
#   }
#   eastasia = {}
# }

# ## security 
# security_settings = {
#   #Azure Security Center Configuration 
#   enable_security_center = false
#   security_center = {
#     contact_email       = "email@email.com"
#     contact_phone       = "9293829328"
#     alerts_to_admins    = true
#     alert_notifications = true
#   }
#   #Enables Azure Sentinel on the Log Analaytics repo
#   enable_sentinel = true
# }
