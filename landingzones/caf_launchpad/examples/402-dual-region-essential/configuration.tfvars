level = "level0"

# Default region
default_region = "region1"

regions = {
  region1 = "southeastasia"
  region2 = "eastasia"
}

launchpad_key_names = {
  keyvault = "launchpad"
  aad_app  = "caf_launchpad_level0"
}

resource_groups = {
  tfstate = {
    name       = "launchpad-tfstates"
    region     = "region1"
    useprefix  = true
    max_length = 40
  }
  security = {
    name       = "launchpad-security"
    useprefix  = true
    max_length = 40
  }
  networking = {
    name       = "networking"
    useprefix  = true
    max_length = 40
  }
  gitops = {
    name       = "launchpad-devops-agents"
    useprefix  = true
    max_length = 40
  }
  ops = {
    name       = "operations"
    useprefix  = true
    max_length = 40
  }
  siem = {
    name       = "siem-logs"
    useprefix  = true
    max_length = 40
  }
}

storage_accounts = {
  level0 = {
    name                     = "level0"
    resource_group_key       = "tfstate"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
    # tags = {
    #   # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
    #   tfstate     = "level0"
    #   environment = "sandpit"
    #   launchpad   = "launchpad"
    # }
  }
  # Stores diagnostic logging for southeastasia
  diaglogs_sea = {
    name                     = "diaglogssea"
    region                   = "region1"
    resource_group_key       = "ops"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
  # Stores diagnostic logging for eastasia
  diaglogs_ea = {
    name                     = "diaglogsae"
    region                   = "region2"
    resource_group_key       = "ops"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
  # Stores security logs for siem southeastasia
  diagsiem_sea = {
    name                     = "siemsea"
    region                   = "region1"
    resource_group_key       = "siem"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
  # Stores diagnostic logging for eastasia
  diagsiem_ea = {
    name                     = "siemae"
    region                   = "region2"
    resource_group_key       = "siem"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}


keyvaults = {
  # Do not rename the key "launchpad" to be able to upgrade to the standard launchpad
  launchpad = {
    name               = "launchpad"
    resource_group_key = "security"
    region             = "region1"
    convention         = "cafrandom"
    sku_name           = "standard"
    tags = {
      tfstate     = "level0"
      environment = "sandpit"
    }

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "default_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
      siem = {
        definition_key   = "siem_all"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
    }

  }

  secrets = {
    name               = "secrets"
    resource_group_key = "security"
    region             = "region1"
    convention         = "cafrandom"
    sku_name           = "premium"

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "default_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
      siem = {
        definition_key   = "siem_all"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
    }
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  launchpad = {
    bootstrap_user = {
      # azuread_group_key = ""
      # azuread_app_key   = ""

      # can be any object_id to reference an existing azure ad application, group or user
      # if set to "logged_in_user" add the user running terraform in the policy (recommended)
      object_id = "logged_in_user"

      key_permissions         = []
      certificate_permissions = []
      secret_permissions      = ["Set", "Get", "List", "Delete"]
    }
    keyvault_level0_rw = {
      azuread_group_key = "keyvault_level0_rw"
      # azuread_app_key   = ""
      # object_id               = ""

      key_permissions         = []
      certificate_permissions = []
      secret_permissions      = ["Set", "Get", "List", "Delete"]
    }
  }

  secrets = {
    launchpad_bootstrap_user = {
      object_id          = "logged_in_user"
      secret_permissions = ["Set", "Get", "List", "Delete"]
    }
    keyvault_password_rotation = {
      azuread_group_key  = "keyvault_password_rotation"
      secret_permissions = ["Set", "Get", "List", "Delete"]
    }
  }
}

subscriptions = {
  logged_in_subscription = {
    role_definition_name = "Owner"
    aad_app_key          = "caf_launchpad_level0"

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "subscription_operations"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
      siem = {
        definition_key   = "subscription_siem"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
    }

  }
}

# WIP - only support user_principal_names (note guest accounts have a special representation)
azuread_groups = {
  keyvault_level0_rw = {
    name        = "caf-level0-keyvault-rw"
    description = "Provide read and write access to the keyvault secrets / level0."
    members = {
      user_principal_names = [
      ]
      group_names      = []
      group_object_ids = []
      group_keys       = []

      service_principal_keys = [
        "caf_launchpad_level0"
      ]
      service_principal_object_id = []

    }
    owners = {
      user_principal_names = [
      ]
      service_principal_keys = [
        "caf_launchpad_level0"
      ]
      service_principal_object_id = []
    }
    prevent_duplicate_name = true
  }

  keyvault_password_rotation = {
    name        = "caf-level0-password-rotation-rw"
    description = "Provide read and write access to the keyvault secrets / level0."
    members = {
      user_principal_names = [
      ]
      group_names      = []
      group_object_ids = []
      group_keys       = []

      service_principal_keys = [
        "caf_launchpad_level0"
      ]
      service_principal_object_id = []

    }
    owners = {
      user_principal_names = [
      ]
      service_principal_keys = [
        "caf_launchpad_level0"
      ]
      service_principal_object_id = []
    }
    prevent_duplicate_name = true
  }
}

azuread_users = {

  # don't change that key
  aad-user-devops-user-admin = {
    convention              = "cafrandom"
    useprefix               = true
    max_length              = 60
    tenant_name             = "terraformdev.onmicrosoft.com"
    user_name               = "caf-level0-security-devops-pat-rotation"
    password_expire_in_days = 180

    # Value must match with var.keyvaults[keyname] to store username and password for password rotation
    keyvault_key = "secrets"
  }

}

azuread_apps = {
  # Do not rename the key "launchpad" to be able to upgrade to the standard launchpad
  caf_launchpad_level0 = {
    convention              = "cafrandom"
    useprefix               = true
    application_name        = "caf_launchpad_level0"
    password_expire_in_days = 180

    # Store the ${secret_prefix}-client-id, ${secret_prefix}-client-secret...
    keyvault = {
      keyvault_key  = "launchpad"
      secret_prefix = "caf-launchpad-level0"
      access_policies = {
        key_permissions    = []
        secret_permissions = ["Get", "List", "Set", "Delete"]
      }
    }
  }

  # Changing that key requires changing the value of azure_devops.aad_app_key
  azure_devops = {
    convention              = "cafrandom"
    useprefix               = true
    application_name        = "caf-level0-security-devops-pat-rotation-aad-app1"
    password_expire_in_days = 60
    tenant_name             = "terraformdev.onmicrosoft.com"
    reply_urls              = ["https://localhost"]
    keyvault = {
      keyvault_key  = "secrets"
      secret_prefix = "caf-level0-security-devops-pat-rotation-aad-app"
      access_policies = {
        key_permissions    = []
        secret_permissions = ["Get", "Set"]
      }
    }
  }

}

networking = {
  devops_sea = {
    resource_group_key = "networking"
    location           = "southeastasia"
    vnet = {
      name          = "devops"
      address_space = ["10.10.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet 
        cidr    = ["10.10.100.0/27"]
        nsg_key = "AzureBastionSubnet"
      }
    }

    # you can setup up to 5 keys - vnet diganostic
    diagnostic_profiles = {
      vnet = {
        definition_key   = "networking_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}

#
# Definition of the networking security groups
#
network_security_group_definition = {
  AzureBastionSubnet = {

    diagnostic_profiles = {
      nsg = {
        definition_key   = "network_security_group"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      operations = {
        name             = "operations"
        definition_key   = "network_security_group"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

    nsg = [
      {
        name                       = "bastion-in-allow",
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
        name                       = "bastion-control-in-allow-443",
        priority                   = "120"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "135"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      },
      {
        name                       = "Kerberos-password-change",
        priority                   = "121"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "4443"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      },
      {
        name                       = "bastion-vnet-out-allow-22",
        priority                   = "103"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "bastion-vnet-out-allow-3389",
        priority                   = "101"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "bastion-azure-out-allow",
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

#
# Define the settings for log analytics workspace and solution map
#
log_analytics = {
  central_logs_sea = {
    region             = "region1"
    name               = "logs"
    resource_group_key = "ops"
    solutions_maps = {
      NetworkMonitoring = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/NetworkMonitoring"
      },
      ADAssessment = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/ADAssessment"
      },
      ADReplication = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/ADReplication"
      },
      AgentHealthAssessment = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/AgentHealthAssessment"
      },
      DnsAnalytics = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/DnsAnalytics"
      },
      ContainerInsights = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/ContainerInsights"
      },
      KeyVaultAnalytics = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/KeyVaultAnalytics"
      }
    }
  }
}

#
# Define the settings for the diagnostics settings
# Demonstrate how to log diagnostics in the correct region
# Different profiles to target different operational teams
#
diagnostics_definition = {
  default_all = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["AuditEvent", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]                 
        ["AllMetrics", true, false, 7],
      ]
    }

  }

  networking_all = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["VMProtectionAlerts", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]                 
        ["AllMetrics", true, false, 7],
      ]
    }

  }

  network_security_group = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["NetworkSecurityGroupEvent", true, false, 7],
        ["NetworkSecurityGroupRuleCounter", true, false, 7],
      ]
      # metric = [
      #   #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]                 
      #   ["AllMetrics", false, false, 7],
      # ]
    }

  }

  compliance_all = {
    name = "compliance_logs"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["AuditEvent", true, true, 365],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]                 
        ["AllMetrics", false, false, 7],
      ]
    }

  }

  siem_all = {
    name = "siem"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["AuditEvent", true, true, 0],
      ]

      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]                 
        ["AllMetrics", false, false, 0],
      ]
    }

  }

  subscription_operations = {
    name = "subscription_operations"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)"] 
        ["Administrative", true],
        ["Security", true],
        ["ServiceHealth", true],
        ["Alert", true],
        ["Policy", true],
        ["Autoscale", true],
        ["ResourceHealth", true],
        ["Recommendation", true],
      ]
    }
  }

  subscription_siem = {
    name = "activity_logs_for_siem"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)"] 
        ["Administrative", false],
        ["Security", true],
        ["ServiceHealth", false],
        ["Alert", false],
        ["Policy", true],
        ["Autoscale", false],
        ["ResourceHealth", false],
        ["Recommendation", false],
      ]
    }

  }

}

diagnostics_destinations = {
  # Storage keys must reference the azure region name
  storage = {
    all_regions = {
      southeastasia = {
        storage_account_key = "diagsiem_sea"
      }
      eastasia = {
        storage_account_key = "diagsiem_ea"
      }
    }
  }

  log_analytics = {
    central_logs = {
      log_analytics_key              = "central_logs_sea"
      log_analytics_destination_type = "Dedicated"
    }
  }
}