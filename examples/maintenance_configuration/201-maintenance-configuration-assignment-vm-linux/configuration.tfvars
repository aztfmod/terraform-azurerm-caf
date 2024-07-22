
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }

  inherit_tags = true

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

# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  example_vm1 = {
    resource_group_key = "vm_region1"
    provision_vm_agent = true
    # when boot_diagnostics_storage_account_key is empty string "", boot diagnostics will be put on azure managed storage
    # when boot_diagnostics_storage_account_key is a non-empty string, it needs to point to the key of a user managed storage defined in diagnostic_storage_accounts
    # if boot_diagnostics_storage_account_key is not defined, but global_settings.resource_defaults.virtual_machines.use_azmanaged_storage_for_boot_diagnostics is true, boot diagnostics will be put on azure managed storage

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "example_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    # Option to use when BYOI (Bring your Own Interface)
    # networking_interface_ids = ["/subscriptions/<subid>/resourceGroups/<rg-name>/providers/Microsoft.Network/networkInterfaces/<nicID>"]

    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "vnet_region1"
        subnet_key              = "example"
        primary                 = true
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
        public_ip_address_key   = "example_vm_pip1_rg1"
        # example with external network objects
        # subnet_id = "/subscriptions/sub-id/resourceGroups/test-manual/providers/Microsoft.Network/virtualNetworks/vnet/subnets/default"
        # public_address_id = "/subscriptions/sub-id/resourceGroups/test-manual/providers/Microsoft.Network/publicIPAddresses/arnaudip"
        # nsg_id = "/subscriptions/sub-id/resourceGroups/test-manual/providers/Microsoft.Network/networkSecurityGroups/nsgtest"

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

        patch_mode                                             = "AutomaticByPlatform"
        bypass_platform_safety_checks_on_user_schedule_enabled = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "example_vm1-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }
        identity = {
          type = "SystemAssigned" #SystemAssigned OR UserAssigned OR SystemAssigned, UserAssigned
          # remote = {
          #   remote_kz_key = { # remote lz key
          #     managed_identity_keys = [""] # remote msi resource key
          #   }
          # }
          # managed_identity_keys = [""] //local msi resource key
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
        # Only Empty is supported. More community contributions required to cover other scenarios
        create_option = "Empty"
        disk_size_gb  = "10"
        lun           = 1
        zones         = ["1"]
      }
    }
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
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
        key_permissions    = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge"]
      }
    }
  }
}

keyvault_keys = {
  key1 = {
    keyvault_key       = "example_vm_rg1"
    resource_group_key = "vm_region1"
    name               = "disk-key"
    key_type           = "RSA"
    key_size           = "2048"
    key_opts           = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]
    tags = {
      encryption = "rsa-204"
    new_tag = "yes" }
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

public_ip_addresses = {
  example_vm_pip1_rg1 = {
    name                    = "example_vm_pip1"
    resource_group_key      = "vm_region1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }
}

maintenance_configuration = {
  mc_re1 = {
    name                     = "example-mc"
    region                   = "region1"
    resource_group_key       = "vm_region1"
    scope                    = "InGuestPatch"
    in_guest_user_patch_mode = "User"
    window = {
      start_date_time = "2023-06-08 15:04"
      duration        = "03:55"
      time_zone       = "Romance Standard Time"
      recur_every     = "2Day"
    }

    install_patches = {
      linux = {
        classifications_to_include = ["Critical", "Security"]
        # package_names_mask_to_exclude      = ["ppt"]
        # package_names_mask_to_include      = ["apt"]
      }
      reboot = "IfRequired"
    }
    # tags               = {} # optional
  }
}

maintenance_assignment_virtual_machine = {
  example = {
    region                        = "region1"
    maintenance_configuration_key = "mc_re1"
    virtual_machine = {
      key = "example_vm1"
    }
  }
}
