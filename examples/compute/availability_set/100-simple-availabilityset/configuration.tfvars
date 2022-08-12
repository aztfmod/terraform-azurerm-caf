global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

provider_azurerm_features_keyvault = {
  // set to true to cleanup the CI
  purge_soft_delete_on_destroy = true
}

availability_sets = {
  avset1 = {
    name               = "sales-re1"
    region             = "region1"
    resource_group_key = "avset"
    # Depends on the region, update and fault domain count availability varies.
    platform_update_domain_count = 2
    platform_fault_domain_count  = 2
    # By default availability set is configured as managed. Below can be used to change it to unmanged.
    # managed                      = false
  }
}

resource_groups = {
  avset = {
    name   = "avset"
    region = "region1"
  }
}



virtual_machines = {
  example_vm1 = {
    resource_group_key = "avset"
    provision_vm_agent = true
    # when boot_diagnostics_storage_account_key is empty string "", boot diagnostics will be put on azure managed storage
    # when boot_diagnostics_storage_account_key is a non-empty string, it needs to point to the key of a user managed storage defined in diagnostic_storage_accounts
    # if boot_diagnostics_storage_account_key is not defined, but global_settings.resource_defaults.virtual_machines.use_azmanaged_storage_for_boot_diagnostics is true, boot diagnostics will be put on azure managed storage
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "example_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "vnet_region1"
        subnet_key              = "example"
        name                    = "0-example-vm1"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0-example-vm1"
      }
    }

    virtual_machine_settings = {
      linux = {
        availability_set_key            = "avset1"
        name                            = "example_vm1"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        custom_data                     = "compute/availability_set/100-simple-availabilityset/scripts/cloud-init/install-rover-tools.config"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "example-vm1-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
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
  example_vm2 = {
    resource_group_key = "avset"
    provision_vm_agent = true
    # when boot_diagnostics_storage_account_key is empty string "", boot diagnostics will be put on azure managed storage
    # when boot_diagnostics_storage_account_key is a non-empty string, it needs to point to the key of a user managed storage defined in diagnostic_storage_accounts
    # if boot_diagnostics_storage_account_key is not defined, but global_settings.resource_defaults.virtual_machines.use_azmanaged_storage_for_boot_diagnostics is true, boot diagnostics will be put on azure managed storage
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "example_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "vnet_region1"
        subnet_key              = "example"
        name                    = "0-example-vm2"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0-example-vm2"
      }
    }

    virtual_machine_settings = {
      linux = {
        availability_set_key            = "avset1"
        name                            = "example_vm2"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        custom_data                     = "compute/availability_set/100-simple-availabilityset/scripts/cloud-init/install-rover-tools.config"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "example-vm2-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
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

keyvaults = {
  example_vm_rg1 = {
    name               = "examplevmsecrets"
    resource_group_key = "avset"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

vnets = {
  vnet_region1 = {
    resource_group_key = "avset"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.110.0/24"]
    }
    specialsubnets = {}
    subnets = {
      example = {
        name = "examples"
        cidr = ["10.100.110.0/29"]
      }
    }

  }
}


diagnostic_storage_accounts = {
  # Stores boot diagnostic for region1
  bootdiag_region1 = {
    name                     = "bootrg1"
    resource_group_key       = "avset"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}