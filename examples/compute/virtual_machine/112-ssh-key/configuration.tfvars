
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
    name = "example-virtual-machine-111-rg1"
  }
}

# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  example_vm1 = {
    resource_group_key = "vm_region1"
    provision_vm_agent = true

    os_type = "linux"

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

        # List of ssh keys to add to the vm
        admin_ssh_keys = {
          # reference a public ssh key in a keyvault secret
          admin = {
            # either one of the option:
            #
            # 1 - (azurerm_ssh_public_key)
            # ssh_public_key_id = "/subscriptions/xxxxxx/resourceGroups/yyy/providers/Microsoft.Compute/sshPublicKeys/ssh-key"

            # 2 - secret value in keyvault local or remote with lz_key
            # lz_key         = ""
            keyvault_key = "example_vm_rg1"
            secret_name  = "ssh-key"

            # 3 - value from keyvault secret_id
            # secret_key_id = "https://xxxx.vault.azure.net/secrets/ssh-key/925267e3xxxxxxx99b4c42c99c418"
          }
        }

        # Spot VM to save money
        priority        = "Spot"
        eviction_policy = "Deallocate"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                    = "example_vm1-os"
          caching                 = "ReadWrite"
          storage_account_type    = "Standard_LRS"
          disk_encryption_set_key = "set1"
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
      }
    }
  }
}

dynamic_keyvault_secrets = {
  example_vm_rg1 = { # Key of the keyvault
    admin_public_ssh_key = {
      secret_name = "ssh-key"
      value       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDPqUVKo4y4WenErQoBpLB6WEbY3/xZ37CLE1va7TS2ezLiAGOY61uxwjNFmvbXTuZB69mwt1q2ZmboYLpAGhXMNf1rtAEBVY4+skgdaWGiftX6YLEMsz0K5ZzwXX+x0NTAoqvprBMpDay9UtNJcjs/dJxS+nxymjq7NBfSbTYKLvO9/sLLwqIxlmmAW2BHgYeZkEPYY4g561v2y7dLIiAfG7GRuvw3PNYT4lnif2aKaeY1grQFUOGa1Yuaxbp4UpLCawIQE9WjXj7woHi3EwSjehLgmI0QtJL4Ho/9kF43ytZt54M2AitrV/LJXWWAeNm4/JDODCoYaj2OwZLk7JTUI2QpP2EN0VwPH4EfX7/vigZya0H2kjXOipyr2NULFwbOKxRWn9bM8bwU1xZINImQ1/WkSDossrcM638nkfsdeau9D9cxzpKi9q1HtXkJNYBCIWYXADtTVMJzet5URPRXYxsmQ6LzuPsxcdneQ7TvxFBJORPwgl8F95pVKjds9Nk= generated-by-azure"
    }
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

