global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  rg1 = {
    name = "vmss-autorepair-exmp-rg"
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
    name                    = "lb_pip1"
    resource_group_key      = "rg1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
  lb_pip2 = {
    name                    = "lb_pip12"
    resource_group_key      = "rg1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

load_balancers = {
  lb1 = {
    name                      = "vmss1"
    sku                       = "standard"
    resource_group_key        = "rg1"
    backend_address_pool_name = "vmss1"
    frontend_ip_configurations = {
      config1 = {
        name                  = "config1"
        public_ip_address_key = "lb_pip1"
      }
    }
    probes = {
      probe1 = {
        resource_group_key = "rg1"
        load_balancer_key  = "lb1"
        probe_name         = "ssh"
        port               = "22"
      }
    }
    lb_rules = {
      rule1 = {
        resource_group_key             = "lb"
        load_balancer_key              = "lb1"
        lb_rule_name                   = "rule1"
        protocol                       = "tcp"
        probe_id_key                   = "probe1"
        frontend_port                  = "22"
        backend_port                   = "22"
        frontend_ip_configuration_name = "config1" #name must match the configuration that's defined in the load_balancers block.
      }
    }
  }

  lb2 = {
    name                      = "lvmss2"
    sku                       = "standard"
    resource_group_key        = "rg1"
    backend_address_pool_name = "vmss2"
    frontend_ip_configurations = {
      config1 = {
        name                  = "config1"
        public_ip_address_key = "lb_pip2"
      }
    }
    probes = {
      probe1 = {
        resource_group_key = "rg1"
        load_balancer_key  = "lb2"
        probe_name         = "rdp"
        port               = "3389"
      }
    }
    lb_rules = {
      rule1 = {
        resource_group_key             = "lb"
        load_balancer_key              = "lb1"
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

        os_disk = {
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
          disk_size_gb         = 128
        }

        identity = {
          type                  = "UserAssigned"
          managed_identity_keys = ["example_mi"]

          remote = {
            lz_key_name = {
              managed_identity_keys = []
            }
          }
        }

        source_image_reference = {
          publisher = "Canonical"
          offer     = "UbuntuServer"
          sku       = "18.04-LTS"
          version   = "latest"
        }

        # To replace unhealthy nodes, add this block and the `health_probe`
        automatic_instance_repair = {
          enabled      = true
          grace_period = "PT30M" # Use ISO8601 expressions.
        }

        # The health is determined by an exising loadbalancer probe.
        health_probe = {
          loadbalancer_key = "lb1"
          probe_key        = "probe1"
        }
      }
    }

    network_interfaces = {
      nic0 = {

        name       = "0"
        primary    = true
        vnet_key   = "vnet1"
        subnet_key = "subnet1"
        load_balancers = {
          lb1 = {
            lb_key = "lb1"
          }
        }

        application_security_groups = {
          asg1 = {
            asg_key = "app_sg1"
          }
        }

        enable_accelerated_networking = false
        enable_ip_forwarding          = false
        internal_dns_name_label       = "nic0"
      }
    }

    data_disks = {
      data1 = {
        caching                   = "None"
        create_option             = "Empty"
        disk_size_gb              = "10"
        lun                       = 1
        storage_account_type      = "Standard_LRS"
        disk_iops_read_write      = 100
        disk_mbps_read_write      = 100
        write_accelerator_enabled = false
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

        upgrade_mode = "Manual"

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

        # To replace unhealthy nodes, add this block and the `health_probe`
        automatic_instance_repair = {
          enabled      = true
          grace_period = "PT30M" # Use ISO8601 expressions.
        }

        # The health is determined by an exising loadbalancer probe.
        health_probe = {
          loadbalancer_key = "lb2"
          probe_key        = "probe1"
        }

      }
    }

    network_interfaces = {
      nic0 = {
        name       = "0"
        primary    = true
        vnet_key   = "vnet1"
        subnet_key = "subnet1"
        load_balancers = {
          lb2 = {
            lb_key = "lb2"
          }
        }

        application_security_groups = {
          asg1 = {
            asg_key = "app_sg1"
          }
        }

        enable_accelerated_networking = false
        enable_ip_forwarding          = false
        internal_dns_name_label       = "nic0"
      }
    }
    ultra_ssd_enabled = false

    data_disks = {
      data1 = {
        caching                   = "None"
        create_option             = "Empty"
        disk_size_gb              = "10"
        lun                       = 1
        storage_account_type      = "Standard_LRS"
        disk_iops_read_write      = 100
        disk_mbps_read_write      = 100
        write_accelerator_enabled = false
      }
    }
  }
}
