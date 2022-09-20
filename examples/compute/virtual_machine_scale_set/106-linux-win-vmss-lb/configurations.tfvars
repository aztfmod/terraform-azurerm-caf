global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  rg1 = {
    name = "vmss-lb-exmp-rg"
  }
}

managed_identities = {
  example_mi = {
    name               = "example_mi"
    resource_group_key = "rg1"
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "rg1"
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
      subnet2 = {
        name = "compute2"
        cidr = ["10.100.2.0/24"]
      }
    }

  }
}


keyvaults = {
  kv1 = {
    name               = "vmsslbexmpkv1"
    resource_group_key = "rg1"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}


diagnostic_storage_accounts = {
  # Stores boot diagnostic for region1
  bootdiag1 = {
    name                     = "lebootdiag1"
    resource_group_key       = "rg1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}

# Application security groups
application_security_groups = {
  app_sg1 = {
    resource_group_key = "rg1"
    name               = "app_sg1"

  }
}

# Load Balancer
public_ip_addresses = {
  lb_pip1 = {
    name               = "lb_pip1"
    resource_group_key = "rg1"
    sku                = "Standard"
    # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    allocation_method = "Static"
    # allocation method needs to be Dynamic
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
  lb_pip2 = {
    name               = "lb_pip12"
    resource_group_key = "rg1"
    sku                = "Standard"
    # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    allocation_method = "Static"
    # allocation method needs to be Dynamic
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

# Public Load Balancer will be created. For Internal/Private Load Balancer config, please refer 102-internal-load-balancer example.

lb = {
  lb1 = {
    name   = "TestLoadBalancer1"
    region = "region1"
    resource_group = {
      key = "rg1"
    }
    frontend_ip_configuration = {
      name = "PublicIPAddress"
      public_ip_address = {
        key = "lb_pip1"
      }
    }
    sku = "standard"
  }
  lb2 = {
    name   = "TestLoadBalancer2"
    region = "region1"
    resource_group = {
      key = "rg1"
    }
    frontend_ip_configuration = {
      name = "PrivateIPAddress"
      subnet = {
        vnet_key = "vnet1"
        key      = "subnet2"
      }
    }
    sku = "Standard"
  }
}


lb_backend_address_pool = {
  lbap1 = {
    loadbalancer = {
      key = "lb1"
    }
    name = "BackEndAddressPool1"
  }
  lbap2 = {
    loadbalancer = {
      key = "lb2"
    }
    name = "BackEndAddressPool2"
  }
}


virtual_machine_scale_sets = {
  vmss1 = {
    resource_group_key                   = "rg1"
    boot_diagnostics_storage_account_key = "bootdiag1"
    os_type                              = "linux"
    keyvault_key                         = "kv1"

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

        identity = {
          # type = "SystemAssigned"
          type                  = "UserAssigned"
          managed_identity_keys = ["example_mi"]

          remote = {
            lz_key_name = {
              managed_identity_keys = []
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
        #subnet_id  = "/subscriptions/97958dac-XXXX-XXXX-XXXX-9f436fa73bd4/resourceGroups/xbvt-rg-vmss-agw-exmp-rg/providers/Microsoft.Network/virtualNetworks/xbvt-vnet-vmss/subnets/xbvt-snet-compute"

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

  }

  vmss2 = {
    resource_group_key                   = "rg1"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag1"
    os_type                              = "windows"
    keyvault_key                         = "kv1"

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

        identity = {
          type                  = "SystemAssigned"
          managed_identity_keys = []
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
        #subnet_id  = "/subscriptions/97958dac-XXXX-XXXX-XXXX-9f436fa73bd4/resourceGroups/xbvt-rg-vmss-agw-exmp-rg/providers/Microsoft.Network/virtualNetworks/xbvt-vnet-vmss/subnets/xbvt-snet-compute"
        load_balancers = {
          lb1 = {
            # lb_key = "lb2"
            lbap_key = "lbap1"
            # lz_key = ""
          }
          lb2 = {
            # lb_key = "lb2"
            lbap_key = "lbap2"
            # lz_key = ""
          }
        }
      }
      nic1 = {
        # Value of the keys from networking.tfvars
        name       = "1"
        vnet_key   = "vnet1"
        subnet_key = "subnet2"
        #subnet_id  = "/subscriptions/97958dac-XXXX-XXXX-XXXX-9f436fa73bd4/resourceGroups/xbvt-rg-vmss-agw-exmp-rg/providers/Microsoft.Network/virtualNetworks/xbvt-vnet-vmss/subnets/xbvt-snet-compute"
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

  }

}