global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  resource_defaults = {
    virtual_machines = {
      # set the below to enable az managed boot diagostics for vms
      # this will be override if a user managed storage account is defined for the vm
      # use_azmanaged_storage_for_boot_diagnostics = true
    }
  }
}

resource_groups = {
  vm_region1 = {
    name = "example-virtual-machine-rg1"
  }
}

vnets = {
  vnet_region1 = {
    resource_group_key = "vm_region1"
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
  vm1 = {
    resource_group_key                   = "vm_region1"
    os_type                              = "linux"
    provision_vm_agent                   = true
    keyvault_key                         = "example_vm_rg1"
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    tags = {
      zone    = "demo"                   
      tier    = "demo"                    
      purpose = "Azure VM Linux with Azure Monitor Agent"      
    }

    networking_interfaces = {
      nic0 = {
        vnet_key                = "vnet_region1"
        subnet_key              = "example"
        primary                 = true
        name                    = "vm-nic"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
      }
    }

    virtual_machine_extensions = {
      azure_monitor_agent = {
        type_handler_version       = "1.22"
        auto_upgrade_minor_version = true
        automatic_upgrade_enabled  = false
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "example_vm1"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        network_interface_keys = ["nic0"]

        source_image_reference = {
          publisher = "Canonical"
          offer     = "UbuntuServer"
          sku       = "18.04-LTS"
          version   = "latest"
        }

        os_disk = {
          name                 = "example_vm1-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
          disk_size_gb         = "30"
        }
        
        identity = {
          type                  = "UserAssigned"
          managed_identity_keys = ["vm_msi"] 
        }
      }
    }

    data_disks = {
      data1 = {
        name                 = "server1-data1"
        storage_account_type = "Standard_LRS"
        create_option = "Empty"
        disk_size_gb  = "128"
        lun           = 1
        zones         = ["1"]
      }
    }
  }
}

diagnostic_storage_accounts = {
  bootdiag_region1 = {
    name                     = "bootrg1"
    resource_group_key       = "vm_region1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}

keyvaults = {
  example_vm_rg1 = {
    name                        = "vmlinuxakv"
    resource_group_key          = "vm_region1"
    sku_name                    = "standard"
    soft_delete_enabled         = true
    purge_protection_enabled    = true
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