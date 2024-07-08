global_settings = {
  regions = {
    region1 = "francecentral"
  }
}


storage_accounts = {
  recovery = {
    name                          = "storage1-recovery"
    resource_group_key            = "backup"
    account_kind                  = "Storage"
    account_tier                  = "Standard"
    account_replication_type      = "LRS"
    min_tls_version               = "TLS1_2"
    public_network_access_enabled = true
  }
}

recovery_vaults = {
  asr1 = {
    name                          = "vault_re1"
    resource_group_key            = "backup"
    region                        = "region1"
    soft_delete_enabled           = true
    public_network_access_enabled = false

    replication_policies = {
      repl1 = {
        name                                                 = "policy1"
        recovery_point_retention_in_minutes                  = 24 * 60
        application_consistent_snapshot_frequency_in_minutes = 0
      }
    }

    identity = {
      # Do not use "SystemAssigned, UserAssigned", there is a bug in the provider
      type = "UserAssigned"
      managed_identities = {
        asr1 = {
          key = "asr1"
        }
      }
    }

    recovery_fabrics = {
      fabric1 = {
        name               = "fab_re1"
        resource_group_key = "backup"
        region             = "region1"
      }
    }

    protection_containers = {
      container1 = {
        name                = "prtc1"
        resource_group_key  = "iaas"
        recovery_fabric_key = "fabric1"
      }
      container2 = {
        name                = "prtc2"
        resource_group_key  = "iaas-secondary"
        recovery_fabric_key = "fabric1"
      }
    }
  }
}

managed_identities = {
  asr = {
    name               = "asr"
    resource_group_key = "backup"
  }
}

virtual_machines = {
  app01 = {
    resource_group_key = "iaas"
    provision_vm_agent = true
    # boot_diagnostics_storage_account_key = "bootdiag_region1"
    os_type      = "windows"
    keyvault_key = "app"

    networking_interfaces = {
      nic0 = {
        vnet_key                = "vnet1"
        subnet_key              = "iaas"
        name                    = "nic0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "example_vm1"
      }
    }

    replication = {
      vault_key                   = "asr1"
      policy_key                  = "repl1"
      staging_storage_account_key = "recovery"

      source = {
        recovery_fabric_key      = "fabric1"
        protection_container_key = "container1"
      }

      target = {
        recovery_fabric_key      = "fabric1"
        protection_container_key = "container2"
        zone                     = "2"
        resource_group_key       = "iaas-secondary"
        network = {
          vnet_key   = "vnet1"
          subnet_key = "iaas_secondary"
        }
        test_network = {
          vnet_key   = "vnet2"
          subnet_key = "test_iaas_secondary"
        }
      }
    }

    virtual_machine_settings = {
      windows = {
        name                   = "example_vm1"
        size                   = "Standard_B2s_v2"
        admin_username         = "adminuser"
        license_type           = "Windows_Server"
        network_interface_keys = ["nic0"]
        zone                   = "1"
        os_disk = {
          name                 = "example_vm1-os"
          caching              = "ReadWrite"
          storage_account_type = "StandardSSD_LRS"
          #  disk_encryption_set_key = "set1"
          zone = "1"
        }
        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2019-datacenter-gensecond"
          version   = "latest"
        }
      }
    }
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "networking"
    region             = "region1"
    vnet = {
      name          = "vnet1"
      address_space = ["10.226.0.0/19"]
    }

    specialsubnets = {}
    subnets = {
      iaas = {
        name              = "NET-IAAS"
        cidr              = ["10.226.18.0/23"]
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
      }
      iaas_secondary = {
        name              = "NET-IAAS-SECONDARY"
        cidr              = ["10.226.22.0/23"]
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
      }
    }
  }
  vnet2 = {
    resource_group_key = "networking"
    region             = "region1"
    vnet = {
      name          = "vnet2"
      address_space = ["10.224.136.0/23"]
    }

    specialsubnets = {}
    subnets = {
      test_iaas_secondary = {
        name              = "NET-IAAS-SECONDARY"
        cidr              = ["10.224.136.0/23"]
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
      }
    }
  }
}

keyvaults = {
  app = {
    name                          = "kv1-recovery"
    resource_group_key            = "iaas"
    sku_name                      = "standard"
    soft_delete_enabled           = true
    public_network_access_enabled = true
  }
}

resource_groups = {
  networking = {
    name = "network_re1"
  }

  iaas = {
    name = "sharedsvc_re1"
  }

  iaas-secondary = {
    name = "sharedsvc_re2"
  }

  backup = {
    name = "backup_re1"
  }
}

role_mapping = {
  built_in_role_mapping = {
    resource_groups = {
      backup = {
        "Contributor" = {
          managed_identities = {
            keys = [
              "asr",
            ]
          }
        }
        "Storage Blob Data Contributor" = {
          managed_identities = {
            keys = [
              "asr",
            ]
          }
        }
        "Storage Blob Data Owner" = {
          managed_identities = {
            keys = [
              "asr",
            ]
          }
        }
      }
    }
  }
}
