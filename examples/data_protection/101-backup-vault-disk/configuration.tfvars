global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  bv = {
    name   = "bv"
    region = "region1"
  }
}

backup_vaults = {
  bv0 = {
    backup_vault_name  = "bckp-level0"
    resource_group_key = "bv"
    datastore_type     = "VaultStore" #Proper type of vault for storage blob backup
    redundancy         = "LocallyRedundant"
    region             = "region1"
    #Next block enables System Assigned managed identity
    enable_identity = {
      type = "SystemAssigned"
    }
  }
}

role_mapping = {
  built_in_role_mapping = {
    resource_groups = {
      bv = {
        "Disk Snapshot Contributor" = {
          backup_vaults = {
            keys = ["bv0"]
          }
        }
        "Disk Backup Reader" = {
          backup_vaults = {
            keys = ["bv0"]
          }
        }
      }
    }
  }
}

backup_vault_policies = {
  policy0 = {
    type                            = "disk"
    backup_vault_key                = "bv0"
    policy_name                     = "backup-policy-lvl0"
    retention_duration              = "P7D"                                #Specific ISO 8601 format
    backup_repeating_time_intervals = ["R/2022-04-20T00:00:00+00:00/PT4H"] # ISO 8601 repeating time interval
    retention_rules = {
      Daily = {
        name              = "Daily"
        duration          = "P7D"
        priority          = 25
        absolute_criteria = "FirstOfDay"
      }
    }
  }
}

backup_vault_instances = {
  data_disk = {
    type                    = "disk"
    instance_name           = "datadisk"
    region                  = "region1"
    backup_vault_key        = "bv0"
    backup_vault_policy_key = "policy0"
    snapshot_resource_group = {
      key = "bv"
    }
    disk = {
      vm_key   = "example_vm1"
      disk_key = "data1"
    }
  }
  os_disk = {
    type                    = "disk"
    instance_name           = "osdisk"
    region                  = "region1"
    backup_vault_key        = "bv0"
    backup_vault_policy_key = "policy0"
    snapshot_resource_group = {
      key = "bv"
    }
    disk = {
      vm_key  = "example_vm1"
      os_disk = true
    }
  }
}

keyvaults = {
  example_vm_rg1 = {
    name               = "vmlinuxakv"
    resource_group_key = "bv"
    sku_name           = "standard"
    # soft_delete_enabled         = true
    purge_protection_enabled    = false
    enabled_for_disk_encryption = true
    tags = {
      env = "Standalone"
    }
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
        key_permissions    = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge"]
      }
    }
  }
}

vnets = {
  vnet_region1 = {
    resource_group_key = "bv"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      example = {
        name = "examples"
        cidr = ["10.100.100.0/29"]
      }
    }

  }
}

virtual_machines = {
  example_vm1 = {
    resource_group_key = "bv"
    os_type            = "linux"

    keyvault_key = "example_vm_rg1"

    networking_interfaces = {
      nic0 = {
        vnet_key                = "vnet_region1"
        subnet_key              = "example"
        primary                 = true
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "example_vm1"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Spot VM to save money
        priority        = "Spot"
        eviction_policy = "Deallocate"

        network_interface_keys = ["nic0"]

        os_disk = {
          name                    = "example_vm1-os"
          caching                 = "ReadWrite"
          storage_account_type    = "Standard_LRS"
          disk_encryption_set_key = "set1"
        }
        identity = {
          type = "SystemAssigned"
        }
        source_image_reference = {
          publisher = "Canonical"
          offer     = "UbuntuServer"
          sku       = "18.04-LTS"
          version   = "latest"
        }
      }
    }
    data_disks = {
      data1 = {
        name                 = "server1-data1"
        storage_account_type = "Standard_LRS"
        create_option        = "Empty"
        disk_size_gb         = "10"
        lun                  = 1
        zones                = ["1"]
      }
    }
  }
}