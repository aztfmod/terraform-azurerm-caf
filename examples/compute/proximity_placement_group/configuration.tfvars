global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  ppg = {
    name   = "ppg"
    region = "region1"
  }
}

proximity_placement_groups = {
  ppg1 = {
    name               = "sales-re1"
    region             = "region1"
    resource_group_key = "ppg"
  }
}

virtual_machines = {
  example_vm1 = {
    resource_group_key = "ppg"
    provision_vm_agent = true

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "example_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key             = "vnet_region1"
        subnet_key           = "example"
        name                 = "ppg_example_vm1-0"
        enable_ip_forwarding = false
      }
    }

    virtual_machine_settings = {
      linux = {
        proximity_placement_group_key   = "ppg1"
        name                            = "ppg_example_vm1"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        custom_data                     = "compute/proximity_placement_group/scripts/cloud-init/install-rover-tools.config"

        # Spot VM to save money
        priority        = "Spot"
        eviction_policy = "Deallocate"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "ppg_example_vm1-os"
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
    resource_group_key = "ppg"
    provision_vm_agent = true

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "example_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key             = "vnet_region1"
        subnet_key           = "example"
        name                 = "ppg_example_vm2-0"
        enable_ip_forwarding = false
      }
    }

    virtual_machine_settings = {
      linux = {
        proximity_placement_group_key   = "ppg1"
        name                            = "ppg_example_vm2"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        custom_data                     = "compute/proximity_placement_group/scripts/cloud-init/install-rover-tools.config"

        # Spot VM to save money
        priority        = "Spot"
        eviction_policy = "Deallocate"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "ppg_example_vm2-os"
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
    resource_group_key = "ppg"
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
    resource_group_key = "ppg"
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
