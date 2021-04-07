global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
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
    proximity_placement_group_key = "ppg1"



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
    resource_group_key                   = "avset"
    provision_vm_agent                   = true
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
        name                    = "00"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic00"
      }
    }

    virtual_machine_settings = {
      linux = {
        availability_set_key            = "avset1"
        proximity_placement_group_key   = "ppg1"
        name                            = "example_vm1"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        custom_data                     = "../../examples/compute/availability_set/101-availabilityset-with-proximity-placement-group/scripts/cloud-init/install-rover-tools.config"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "example_vm1-os"
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
    resource_group_key                   = "avset"
    provision_vm_agent                   = true
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
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0-1"
      }
    }

    virtual_machine_settings = {
      linux = {
        availability_set_key            = "avset1"
        proximity_placement_group_key   = "ppg1"
        name                            = "example_vm2"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        custom_data                     = "../../examples/compute/availability_set/101-availabilityset-with-proximity-placement-group/scripts/cloud-init/install-rover-tools.config"

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


proximity_placement_groups = {
  ppg1 = {
    name               = "example-ppg"
    region             = "region1"
    resource_group_key = "avset"
  }
}




