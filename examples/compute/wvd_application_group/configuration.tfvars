global_settings = {
  default_region = "region1"
  environment    = "test"
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

wvd_application_groups = {
  wvd_app1 = {
    resource_group_key  = "wvd_region1"
    host_pool_key       = "wvd_hp1"
    wvd_workspace_key   = "wvd_ws1"
    name                = "firstapp"
    friendly_name      = "Myappgroup"
    description        = "A description of my workspace"
    #Type of Virtual Desktop Application Group. Valid options are RemoteApp or Desktop.
    type          = "RemoteApp"
    
  }
}

wvd_host_pools = {
  wvd_hp1 = {
    resource_group_key  = "wvd_region1"
    name                = "firsthp"
    friendly_name      = "Myhostpool"
    description        = "A description of my workspace"
    validate_environment     = true
    type                     = "Pooled"
    #Option to specify the preferred Application Group type for the Virtual Desktop Host Pool. Valid options are None, Desktop or RailApplications.
    preferred_app_group_type = "RailApplications"
    maximum_sessions_allowed = 1000
    load_balancer_type       = "DepthFirst"
    #Expiration value should be between 1 hour and 30 days.
    registration_info = {
      expiration_date = "2021-02-19T07:20:50.52Z"
    }
  }
}

wvd_workspaces = {

  wvd_ws1 = {
    resource_group_key  = "wvd_region1"
    name                = "firstws"
    friendly_name      = "Myworkspace"
    description        = "A description of my workspace"
  }
}


# Virtual machines
virtual_machines = {
  
  windows_server1 = {
    resource_group_key                   = "wvd_region1"
    boot_diagnostics_storage_account_key = "bootdiag_region1"
    provision_vm_agent                   = true

    os_type = "windows"

    # when not set the password is auto-generated and stored into the keyvault
    keyvault_key = "test_client"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        vnet_key                = "vnet_region1"
        subnet_key              = "example"
        name                    = "0-server1"
        enable_ip_forwarding    = false
        internal_dns_name_label = "server1-nic0"
        public_ip_address_key   = "example_vm_pip1_rg1"

      }
    }

    virtual_machine_settings = {
      windows = {
        name               = "wvdserver"
        availability_set_key = "avset1"
        size               = "Standard_F2s_v2"
        admin_username_key = "vmadmin-username"
        admin_password_key = "vmadmin-password"
        

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        # zone = "1"

        os_disk = {
          name                 = "server1-os"
          caching              = "ReadWrite"
          create_option        = "FromImage"
          storage_account_type = "Standard_LRS"
          managed_disk_type    = "StandardSSD_LRS"
          disk_size_gb         = "128"
        }

        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2019-Datacenter"
          version   = "latest"
        }

        winrm = {
          enable_self_signed = true
        }

      }
    }



    # data_disks = {
    #   data1 = {
    #     name                 = "server1-data1"
    #     storage_account_type = "Standard_LRS"
    #     # Only Empty is supported. More community contributions required to cover other scenarios
    #     create_option = "Empty"
    #     disk_size_gb  = "10"
    #     lun           = 1
    #     zones         = ["1"]
    #   }
    # }

    virtual_machine_extensions = {
      additional_session_host_dscextension = {
        name                       = "additional_session_host_dscextension"
        svcprincipal_app_id        = "37c2a35a-042f-436a-9216-54f1c72cc69d"
        svcprincipal_creds_value   = "2KcGffYBBCeyIu48Et/tzw2RfbAY/yy/+hBbOakLZKo="
        is_service_principal       = "true"
        aad_tenant_id              = "0873a9b0-a78c-47e6-b937-5a1c3053f4a7"
        wvd_tenant_name            = "new-wvd"
        RDBrokerURL                = "https://rdbroker.wvd.microsoft.com"
        registration_expiration_hours = "48"
        host_pool_name                = "firsthp"
        existing_tenant_group_name    = "Default Tenant Group"
        base_url = "https://raw.githubusercontent.com/Azure/RDS-Templates/master/wvd-templates"
      }

      microsoft_azure_domainJoin = {
        name = "microsoft_azue_dromainJoin"
        domain_name = "dns.demos.llc"
        domain_password = "@@lhftfjknbh88AABBKKJHKJHlljj#"
        ou_path = ""
        user = "adminaad@demos.llc"
        restart = "true"
        options = "3"

      }

      # custom_script_extensions = {
      #   name = "custom_script_extensions"
      # }
    }
  
  }

}

# Store output attributes into keyvault secret
dynamic_keyvault_secrets = {
  ssh_keys = { # Key of the keyvault
    vmadmin-username = {
      secret_name = "vmadmin-username"
      value       = "vmadmin"
    }
    vmadmin-password = {
      secret_name = "vmadmin-password"
      value       = "Very@Str5ngP!44w0rdToChaNge#"
    }
  }
}




# ## Networking configuration
vnets = {
  vnet_region1 = {
    resource_group_key = "wvd_region1"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.100.0/24"]
      dns_servers = ["10.0.1.4", "10.0.1.5"]
    }
    specialsubnets = {}
    
    subnets = {
      example = {
        name = "examples"
        cidr = ["10.100.100.0/25"]
      }
      
    }

  }
}

public_ip_addresses = {
  example_vm_pip1_rg1 = {
    name                    = "example_vm_pip1"
    resource_group_key      = "wvd_region1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }
}

availability_sets = {
  avset1 = {
    name               = "example_avset"
    region             = "region1"
    resource_group_key = "wvd_region1"
    # Depends on the region, update and fault domain count availability varies.
    platform_update_domain_count = 2
    platform_fault_domain_count  = 2
    # By default availability set is configured as managed. Below can be used to change it to unmanged.
    # managed                      = false
  }
}

# keyvaults = {
#   ssh_keys = {
#     name               = "vmsecrets"
#     resource_group_key = "wvd_region1"
#     sku_name           = "standard"
#     enabled_for_deployment = true

#     creation_policies = {
#       logged_in_user = {
#         certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover"]
#         secret_permissions      = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
#       }
#     }
#   }
# }

keyvaults = {
  test_client = {
    name                = "testkv"
    resource_group_key  = "wvd_region1"
    sku_name            = "standard"
    soft_delete_enabled = true
    enabled_for_deployment = true
    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover"]
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

keyvault_access_policies_azuread_apps = {
  test_client = {
    test_client = {
      azuread_app_key    = "test_client"
      secret_permissions = ["Set", "Get", "List", "Delete"]
    }
  }
}

azuread_apps = {
  test_client = {
    useprefix        = true
    application_name = "test-client"
    password_policy = {
      # Length of the password
      length  = 250
      special = false
      upper   = true
      number  = true

      # Define the number of days the password is valid. It must be more than the rotation frequency
      expire_in_days = 10
      rotation = {
        #
        # Set how often the password must be rotated. When passed the renewal time, running the terraform plan / apply will change to a new password
        # Only set one of the value
        #

        # mins   = 10     # only recommended for CI and demo
        days = 7
        # months = 1
      }
    }
    app_role_assignment_required = true
    keyvaults = {
      test_client = {
        secret_prefix = "test-client"
      }
    }
    # Store the ${secret_prefix}-client-id, ${secret_prefix}-client-secret...
    # Set the policy during the creation process of the launchpad
  }
}

#complete list of built-in-roles : https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles

role_mapping = {
  built_in_role_mapping = {
    subscriptions = {
      # subcription level access
      logged_in_subscription = {
        "Contributor" = {
          azuread_apps = {
            keys = ["test_client"]
          }
        }
      }
    }
  }
}

azuread_roles = {
  packer_client = {
    roles = [
      "Contributor"
    ]
  }
}




