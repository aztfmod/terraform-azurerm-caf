global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

tags = {
  level = "100"
}

resource_groups = {
  example_vmss_rg1 = {
    name = "vmss-lb-cse-rg"
  }
}

# Managed identity to attach to vm to download from the storage account
managed_identities = {
  example_vmss_mi = {
    name               = "example_vmss_mi"
    resource_group_key = "example_vmss_rg1"
  }
}

storage_accounts = {
  sa1 = {
    name               = "sa1"
    resource_group_key = "example_vmss_rg1"
    # Account types are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2
    #account_kind = "BlobStorage"
    # Account Tier options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    account_tier = "Standard"
    #  Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS
    account_replication_type = "LRS" # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    containers = {
      files = {
        name = "files"
      }
    }
  }
}

# Upload helloworld scripts
storage_account_blobs = {
  script1 = {
    name                   = "helloworld.sh"
    storage_account_key    = "sa1"
    storage_container_name = "files"
    source                 = "./compute/virtual_machine_scale_set/102-linux-win-vmss-custom-script-extension/scripts/helloworld.sh"
    parallelism            = 1
  }
  script2 = {
    name                   = "helloworld.ps1"
    storage_account_key    = "sa1"
    storage_container_name = "files"
    source                 = "./compute/virtual_machine_scale_set/102-linux-win-vmss-custom-script-extension/scripts/helloworld.ps1"
    parallelism            = 1
  }
}

# Give managed identity Storage Blob Data reader and executing user Storage Blob Data Contributor permissions on storage account
role_mapping = {
  built_in_role_mapping = {
    storage_accounts = {
      sa1 = {
        "Storage Blob Data Reader" = {
          managed_identities = {
            keys = ["example_vmss_mi"]
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

vnets = {
  vnet1 = {
    resource_group_key = "example_vmss_rg1"
    vnet = {
      name          = "vmss"
      address_space = ["10.100.0.0/16"]
    }
    specialsubnets = {}
    subnets = {
      subnet1 = {
        name = "compute"
        cidr = ["10.100.1.0/24"]
      }
    }
  }
}

keyvaults = {
  example_vmss_kv1 = {
    name               = "vmsecretskv"
    resource_group_key = "example_vmss_rg1"
    sku_name           = "standard"
    tags = {
      env = "Standalone"
    }
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

# Store output attributes into keyvault secret
dynamic_keyvault_secrets = {
  example_vmss_kv1 = { # Key of the keyvault
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

diagnostic_storage_accounts = {
  # Stores boot diagnostic for region1
  bootdiag1 = {
    name                     = "lebootdiag1"
    resource_group_key       = "example_vmss_rg1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}

# Application security groups
application_security_groups = {
  app_sg1 = {
    resource_group_key = "example_vmss_rg1"
    name               = "app_sg1"
  }
}

# Load Balancer
public_ip_addresses = {
  lb_pip1 = {
    name               = "lb_pip1"
    resource_group_key = "example_vmss_rg1"
    sku                = "Basic"
    # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    allocation_method = "Dynamic"
    # allocation method needs to be Dynamic
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
  lb_pip2 = {
    name               = "lb_pip2"
    resource_group_key = "example_vmss_rg1"
    sku                = "Basic"
    # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    allocation_method = "Dynamic"
    # allocation method needs to be Dynamic
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

# Public Load Balancer will be created. For Internal/Private Load Balancer config, please refer 102-internal-load-balancer example.
load_balancers = {
  lb1 = {
    name                      = "lb-vmss1"
    sku                       = "basic"
    resource_group_key        = "example_vmss_rg1"
    backend_address_pool_name = "vmss1"
    frontend_ip_configurations = {
      config1 = {
        name                  = "config1"
        public_ip_address_key = "lb_pip1"
      }
    }
    probes = {
      probe1 = {
        resource_group_key  = "example_vmss_rg1"
        load_balancer_key   = "lb1"
        probe_name          = "probe1"
        port                = "22"
        interval_in_seconds = "20"
        number_of_probes    = "3"
      }
    }
    lb_rules = {
      rule1 = {
        resource_group_key             = "example_vmss_rg1"
        load_balancer_key              = "lb1"
        lb_rule_name                   = "rule1"
        protocol                       = "tcp"
        probe_id_key                   = "probe1"
        frontend_port                  = "22"
        backend_port                   = "22"
        enable_floating_ip             = "false"
        idle_timeout_in_minutes        = "4"
        load_distribution              = "SourceIPProtocol"
        disable_outbound_snat          = "false"
        enable_tcp_rest                = "false"
        frontend_ip_configuration_name = "config1" # name must match the configuration that's defined in the load_balancers block.
      }
    }
  }
  lb2 = {
    name                      = "lb-vmss2"
    sku                       = "basic"
    resource_group_key        = "example_vmss_rg1"
    backend_address_pool_name = "vmss2"
    frontend_ip_configurations = {
      config1 = {
        name                  = "config1"
        public_ip_address_key = "lb_pip2"
      }
    }
    probes = {
      probe1 = {
        resource_group_key  = "example_vmss_rg1"
        load_balancer_key   = "lb2"
        probe_name          = "probe1"
        port                = "3389"
        interval_in_seconds = "20"
        number_of_probes    = "3"
      }
    }
    lb_rules = {
      rule1 = {
        resource_group_key             = "example_vmss_rg1"
        load_balancer_key              = "lb2"
        lb_rule_name                   = "rule1"
        protocol                       = "tcp"
        probe_id_key                   = "probe1"
        frontend_port                  = "3389"
        backend_port                   = "3389"
        enable_floating_ip             = "false"
        idle_timeout_in_minutes        = "4"
        load_distribution              = "SourceIPProtocol"
        disable_outbound_snat          = "false"
        enable_tcp_rest                = "false"
        frontend_ip_configuration_name = "config1" # name must match the configuration that's defined in the load_balancers block.
      }
    }
  }
}

virtual_machine_scale_sets = {
  vmss1 = {
    resource_group_key                   = "example_vmss_rg1"
    boot_diagnostics_storage_account_key = "bootdiag1"
    os_type                              = "linux"
    keyvault_key                         = "example_vmss_kv1"

    vmss_settings = {
      linux = {
        name                            = "linux_vmss1"
        computer_name_prefix            = "lnx"
        sku                             = "Standard_F2"
        instances                       = 1
        admin_username                  = "adminuser"
        disable_password_authentication = true
        provision_vm_agent              = true
        priority                        = "Spot"
        eviction_policy                 = "Deallocate"
        ultra_ssd_enabled               = false # required if planning to use UltraSSD_LRS

        upgrade_mode = "Manual" # Automatic / Rolling / Manual

        # rolling_upgrade_policy = {
        #   # Only for upgrade mode = "Automatic / Rolling "
        #   max_batch_instance_percent = 20
        #   max_unhealthy_instance_percent = 20
        #   max_unhealthy_upgraded_instance_percent = 20
        #   pause_time_between_batches = ""
        # }
        # automatic_os_upgrade_policy = {
        #   # Only for upgrade mode = "Automatic"
        #   disable_automatic_rollback = false
        #   enable_automatic_os_upgrade = true
        # }

        os_disk = {
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
          disk_size_gb         = 128
          # disk_encryption_set_key = ""
          # lz_key = ""
        }

        # Uncomment in case the managed_identity_keys are generated locally
        # identity = {
        #   type                  = "UserAssigned"
        #   managed_identity_keys = ["example_vmss_id"]
        # }

        # Uncomment in case the managed_identity_keys are generated in a different landingzone
        identity = {
          type = "UserAssigned"
          remote = {
            examples = {
              managed_identity_keys = ["example_vmss_mi"]
            }
          }
        }

        # custom_image_id = ""

        source_image_reference = {
          publisher = "Canonical"
          offer     = "UbuntuServer"
          sku       = "18.04-LTS"
          version   = "latest"
        }

      }
    }

    network_interfaces = {
      # option to assign each nic to different LB/ App GW

      nic0 = {

        name       = "0"
        primary    = true
        vnet_key   = "vnet1"
        subnet_key = "subnet1"
        load_balancers = {
          lb1 = {
            lb_key = "lb1"
            # lz_key = ""
          }
        }

        application_security_groups = {
          asg1 = {
            asg_key = "app_sg1"
            # lz_key = ""
          }
        }

        enable_accelerated_networking = false
        enable_ip_forwarding          = false
        internal_dns_name_label       = "nic0"
      }
    }

    data_disks = {
      data1 = {
        caching                   = "None"  # None / ReadOnly / ReadWrite
        create_option             = "Empty" # Empty / FromImage (only if source image includes data disks)
        disk_size_gb              = "10"
        lun                       = 1
        storage_account_type      = "Standard_LRS" # UltraSSD_LRS only possible when > additional_capabilities { ultra_ssd_enabled = true }
        disk_iops_read_write      = 100            # only for UltraSSD Disks
        disk_mbps_read_write      = 100            # only for UltraSSD Disks
        write_accelerator_enabled = false          # true requires Premium_LRS and caching = "None"
        # disk_encryption_set_key = "set1"
        # lz_key = "" # lz_key for disk_encryption_set_key if remote
      }
    }

    virtual_machine_scale_set_extensions = {
      custom_script = {
        # You can define fileuris directly or use fileuri_sa reference keys and lz_key:
        # fileuris                  = ["https://somelocation/container/script.ps1"]
        fileuri_sa_key            = "sa1"
        fileuri_sa_path           = "files/helloworld.sh"
        commandtoexecute          = "bash helloworld.sh"
        identity_type             = "UserAssigned" # optional to use managed_identity for download from location specified in fileuri, UserAssigned or SystemAssigned.
        lz_key                    = "examples"
        managed_identity_key      = "example_vmss_mi"
        automatic_upgrade_enabled = false
        # managed_identity_id       = "id" # optional to define managed identity principal_id directly
        # lz_key                    = "other_lz" # optional for managed identity defined in other lz
      }
    }
  }

  vmss2 = {
    resource_group_key                   = "example_vmss_rg1"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag1"
    os_type                              = "windows"
    keyvault_key                         = "example_vmss_kv1"

    vmss_settings = {
      windows = {
        name                            = "win"
        computer_name_prefix            = "win"
        sku                             = "Standard_F2"
        instances                       = 1
        admin_username                  = "adminuser"
        disable_password_authentication = true
        priority                        = "Spot"
        eviction_policy                 = "Deallocate"

        upgrade_mode = "Manual" # Automatic / Rolling / Manual

        # rolling_upgrade_policy = {
        #   # Only for upgrade mode = "Automatic / Rolling "
        #   max_batch_instance_percent = 20
        #   max_unhealthy_instance_percent = 20
        #   max_unhealthy_upgraded_instance_percent = 20
        #   pause_time_between_batches = ""
        # }
        # automatic_os_upgrade_policy = {
        #   # Only for upgrade mode = "Automatic"
        #   disable_automatic_rollback = false
        #   enable_automatic_os_upgrade = true
        # }

        os_disk = {
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
          disk_size_gb         = 128
        }

        # Uncomment in case the managed_identity_keys are generated locally
        # identity = {
        #   type                  = "UserAssigned"
        #   managed_identity_keys = ["example_vmss_id"]
        # }

        # Uncomment in case the managed_identity_keys are generated in a different landingzone
        identity = {
          type = "UserAssigned"
          remote = {
            examples = {
              managed_identity_keys = ["example_vmss_mi"]
            }
          }
        }

        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2016-Datacenter"
          version   = "latest"
        }

      }
    }

    network_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        name       = "0"
        primary    = true
        vnet_key   = "vnet1"
        subnet_key = "subnet1"

        load_balancers = {
          lb2 = {
            lb_key = "lb2"
            # lz_key = ""
          }
        }

        application_security_groups = {
          asg1 = {
            asg_key = "app_sg1"
            # lz_key = ""
          }
        }

        enable_accelerated_networking = false
        enable_ip_forwarding          = false
        internal_dns_name_label       = "nic0"
      }
    }
    ultra_ssd_enabled = false # required if planning to use UltraSSD_LRS

    data_disks = {
      data1 = {
        caching                   = "None"  # None / ReadOnly / ReadWrite
        create_option             = "Empty" # Empty / FromImage (only if source image includes data disks)
        disk_size_gb              = "10"
        lun                       = 1
        storage_account_type      = "Standard_LRS" # UltraSSD_LRS only possible when > additional_capabilities { ultra_ssd_enabled = true }
        disk_iops_read_write      = 100            # only for UltraSSD Disks
        disk_mbps_read_write      = 100            # only for UltraSSD Disks
        write_accelerator_enabled = false          # true requires Premium_LRS and caching = "None"
        # disk_encryption_set_key = "set1"
        # lz_key = "" # lz_key for disk_encryption_set_key if remote
      }
    }

    virtual_machine_scale_set_extensions = {
      custom_script = {
        # You can define fileuris directly or use fileuri_sa reference keys and lz_key:
        # fileuris                  = ["https://somelocation/container/script.ps1"]
        fileuri_sa_key            = "sa1"
        fileuri_sa_path           = "files/helloworld.ps1"
        commandtoexecute          = "PowerShell -file helloworld.ps1"
        identity_type             = "UserAssigned" # optional to use managed_identity for download from location specified in fileuri, UserAssigned or SystemAssigned.
        lz_key                    = "examples"
        managed_identity_key      = "example_vmss_mi"
        automatic_upgrade_enabled = false
        # managed_identity_id       = "id" # optional to define managed identity principal_id directly
        # lz_key                    = "other_lz" # optional for managed identity defined in other lz
      }
    }
  }
}
