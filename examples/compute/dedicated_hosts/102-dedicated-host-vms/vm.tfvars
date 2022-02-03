
# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  example_vm1 = {
    resource_group_key = "dhg"
    provision_vm_agent = true
    # when boot_diagnostics_storage_account_key is empty string "", boot diagnostics will be put on azure managed storage
    # when boot_diagnostics_storage_account_key is a non-empty string, it needs to point to the key of a user managed storage defined in diagnostic_storage_accounts
    # if boot_diagnostics_storage_account_key is not defined, but global_settings.resource_defaults.virtual_machines.use_azmanaged_storage_for_boot_diagnostics is true, boot diagnostics will be put on azure managed storage

    os_type = "windows"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "example_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "vnet_region1"
        subnet_key              = "example"
        name                    = "0-windows"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0-vm1"
      }
    }

    virtual_machine_settings = {
      windows = {
        name           = "example_vm1"
        size           = "Standard_D2s_v3"
        admin_username = "adminuser"

        dedicated_host = {
          key = "dh1"
          # lz_key = "remoteLZKey"
          # id = "full resource ID"
        }

        # Spot VM to save money
        priority        = "Spot"
        eviction_policy = "Deallocate"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "example_vm1-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2019-Datacenter"
          version   = "latest"
        }

      }
    }

  }
  example_vm2 = {
    resource_group_key = "dhg"
    provision_vm_agent = true

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "example_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "vnet_region1"
        subnet_key              = "example"
        primary                 = true
        name                    = "0-linux"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0-vm2"

      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "example_vm2"
        size                            = "Standard_D2s_v3"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        dedicated_host = {
          key = "dh1"
          # lz_key = "remoteLZKey"
          # id = "full resource ID"
        }


        # Spot VM to save money
        priority        = "Spot"
        eviction_policy = "Deallocate"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "example_vm2-os"
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
    name               = "vmsecrets"
    resource_group_key = "dhg"
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
    resource_group_key = "dhg"
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
