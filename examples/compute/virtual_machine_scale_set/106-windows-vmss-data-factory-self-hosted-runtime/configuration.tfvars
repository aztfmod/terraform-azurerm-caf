global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  integration = {
    name   = "integration"
    region = "region1"
  }
}

vnets = {
  vnet_region1 = {
    resource_group_key = "integration"
    vnet = {
      name          = "vnet1"
      address_space = ["10.0.0.0/21"]
    }
    subnets = {
      services = {
        name              = "services"
        cidr              = ["10.0.0.0/24"]
        service_endpoints = ["Microsoft.KeyVault"]
      }
    }
  }
}

keyvaults = {
  kv1 = {
    name                     = "integration"
    resource_group_key       = "integration"
    sku_name                 = "standard"
    soft_delete_enabled      = true
    purge_protection_enabled = true
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

diagnostic_storage_accounts = {
  # Stores boot diagnostic for region1
  bootdiag1 = {
    name                     = "lebootdiag1"
    resource_group_key       = "integration"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Hot"
  }
}

data_factory = {
  df1 = {
    name = "adf-int"
    resource_group = {
      key = "integration"
      #lz_key = ""
      #name = ""
    }
    managed_virtual_network_enabled = "true"
  }
}

data_factory_integration_runtime_self_hosted = {
  dfirsh1 = {
    name = "adfsharedshir"
    resource_group = {
      key = "integration"
    }
    data_factory = {
      key = "df1"
    }
  }
}


storage_accounts = {
  sa1 = {
    name                     = "sa1"
    resource_group_key       = "integration"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    containers = {
      files = {
        name = "files"
      }
    }
  }
}

storage_account_blobs = {
  script1 = {
    name                   = "installSHIRGateway.ps1"
    storage_account_key    = "sa1"
    storage_container_name = "files"
    source_uri             = "https://raw.githubusercontent.com/Azure/data-landing-zone/main/code/installSHIRGateway.ps1"
    parallelism            = 1
  }
}




public_ip_addresses = {
  lb_pip1 = {
    name               = "lb_pip1"
    resource_group_key = "integration"
    sku                = "Basic"
    # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    allocation_method = "Dynamic"
    # allocation method needs to be Dynamic
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

# Application security groups
application_security_groups = {
  app_sg1 = {
    resource_group_key = "integration"
    name               = "app_sg1"
  }
}

# Load Balancer
# Public Load Balancer will be created. For Internal/Private Load Balancer config, please refer 102-internal-load-balancer example.
load_balancers = {
  lb-vmss = {
    name                      = "lb-vmss"
    sku                       = "basic"
    resource_group_key        = "integration"
    backend_address_pool_name = "vmss1"
    frontend_ip_configurations = {
      config1 = {
        name                  = "config1"
        public_ip_address_key = "lb_pip1"
      }
    }
    probes = {
      probe1 = {
        resource_group_key = "integration"
        load_balancer_key  = "lb-vmss"
        probe_name         = "rdp"
        port               = "3389"
      }
    }
    lb_rules = {
      rule1 = {
        resource_group_key             = "integration"
        load_balancer_key              = "lb-vmss"
        lb_rule_name                   = "rule1"
        protocol                       = "tcp"
        probe_id_key                   = "probe1"
        frontend_port                  = "3389"
        backend_port                   = "3389"
        frontend_ip_configuration_name = "config1" #name must match the configuration that's defined in the load_balancers block.
      }
    }
  }
}

managed_identities = {
  vmssadf = {
    name               = "vmssadf"
    resource_group_key = "integration"
  }
}

virtual_machine_scale_sets = {
  vmssshir = {
    resource_group_key                   = "integration"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag1"
    os_type                              = "windows"
    keyvault_key                         = "kv1"

    vmss_settings = {
      windows = {
        name                            = "win"
        computer_name_prefix            = "win"
        sku                             = "Standard_F2"
        instances                       = 2
        admin_username                  = "adminuser"
        disable_password_authentication = false
        priority                        = "Spot"
        eviction_policy                 = "Deallocate"
        upgrade_mode                    = "Automatic" # Automatic / Rolling / Manual
        #custom_data                     = "scripts/installSHIRGateway.ps1"

        rolling_upgrade_policy = {
          #   # Only for upgrade mode = "Automatic / Rolling "
          max_batch_instance_percent              = 60
          max_unhealthy_instance_percent          = 60
          max_unhealthy_upgraded_instance_percent = 60
          pause_time_between_batches              = "PT01M"
        }
        automatic_os_upgrade_policy = {
          # Only for upgrade mode = "Automatic"
          disable_automatic_rollback  = false
          enable_automatic_os_upgrade = true
        }

        os_disk = {
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
          disk_size_gb         = 128
        }

        # Uncomment in case the managed_identity_keys are generated locally
        identity = {
          type                  = "UserAssigned"
          managed_identity_keys = ["vmssadf"]
        }

        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2019-Datacenter"
          version   = "latest"
        }

        automatic_instance_repair = {
          enabled      = true
          grace_period = "PT30M" # Use ISO8601 expressions.
        }

        # The health is determined by an exising loadbalancer probe.
        health_probe = {
          loadbalancer_key = "lb-vmss"
          probe_key        = "probe1"
        }

      }
    }

    network_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        name       = "0"
        primary    = true
        vnet_key   = "vnet_region1"
        subnet_key = "services"
        #subnet_id  = "/subscriptions/97958dac-XXXX-XXXX-XXXX-9f436fa73bd4/resourceGroups/xbvt-rg-vmss-agw-exmp-rg/providers/Microsoft.Network/virtualNetworks/xbvt-vnet-vmss/subnets/xbvt-snet-compute"

        enable_accelerated_networking = false
        enable_ip_forwarding          = false
        internal_dns_name_label       = "nic0"
        load_balancers = {
          lb1 = {
            lb_key = "lb-vmss"
            # lz_key = ""
          }
        }
        application_security_groups = {
          asg1 = {
            asg_key = "app_sg1"
            # lz_key = ""
          }
        }
      }
    }
    ultra_ssd_enabled = false # required if planning to use UltraSSD_LRS

    virtual_machine_scale_set_extensions = {
      data_factory_self_hosted_integration_runtime = {
        self_hosted_integration_runtime_auth_key = null
        data_factory_self_hosted_integration_runtime = {
          key = "dfirsh1"
        }

        identity_type             = "UserAssigned" # optional to use managed_identity for download from location specified in fileuri, UserAssigned or SystemAssigned.
        managed_identity_key      = "vmssadf"
        automatic_upgrade_enabled = false

        #########################
        #  base_command_to_execute is used in conjunction with a Self-Hosted Integration Runtime authorization key
        #  retrieved from Azure Key Vault using the vault_settings parameters
        #########################
        base_command_to_execute = "powershell.exe -ExecutionPolicy Unrestricted -File installSHIRGateway.ps1 -gatewayKey"
        #base_command_to_execute   = "powershell.exe -ExecutionPolicy Unrestricted -NoProfile -NonInteractive -command"


        #########################
        #  command_override supercedes base_command_to_execute, allowing
        #  the Self-Hosted Integration Runtime authorization key to be defined inline
        #  or alternative logic implemented
        #########################
        #command_override = "powershell.exe -File C:/pathTo/script.ps1"


        #########################
        # You can define fileuris directly or use fileuri_sa reference keys and lz_key:
        #########################
        fileuris = ["https://raw.githubusercontent.com/Azure/data-landing-zone/main/code/installSHIRGateway.ps1"]
        #fileuri_sa_key          = "sa1"
        #fileuri_sa_path         = "files/installSHIRGateway.ps1"
        #lz_key                    = "examples"
        # managed_identity_id       = "id" # optional to define managed identity principal_id directly
        # lz_key                    = "other_lz" # optional for managed identity defined in other lz
      }
    }

  }
}

role_mapping = {
  built_in_role_mapping = {
    keyvaults = {
      kv1 = {
        "Key Vault Secrets User" = {
          logged_in = {
            keys = ["user"]
          }
          managed_identities = {
            keys = ["vmssadf"]
          }
        }
      }
    }
    storage_accounts = {
      sa1 = {
        "Storage Blob Data Reader" = {
          managed_identities = {
            keys = ["vmssadf"]
          }
        }
        "Storage Blob Data Contributor" = {
          logged_in = {
            keys = ["user"]
          }
        }
      }
    }
  }
}
