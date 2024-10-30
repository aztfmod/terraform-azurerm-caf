
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
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
  example_vm1 = {
    resource_group_key                   = "vm_region1"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"
    os_type                              = "linux"
    keyvault_key                         = "example_vm_rg1"

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
    virtual_machine_extensions = {
      linux_diagnostic = {
        ladcfg_file_path               = "./compute/virtual_machine/216-vm-linux_diagnostic_extensions/diagnostics/ladcfg.json"
        filelogs_file_path             = "./compute/virtual_machine/216-vm-linux_diagnostic_extensions/diagnostics/filelogs.json"
        diagnostic_storage_account_key = "bootdiag_region1"
      }
    }
    virtual_machine_settings = {
      linux = {
        name                            = "example_vm1"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        network_interface_keys          = ["nic0"]

        os_disk = {
          name                 = "example_vm1-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
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
    name               = "vmlinuxdiac"
    resource_group_key = "vm_region1"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
        key_permissions    = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge"]
      }
    }
  }
}