global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
}

tags = {
  level = "100"
}

resource_groups = {
  vm_region1 = {
    name = "example-virtual-machine-rg1"
    tags = {
      env = "standalone"
    }
  }
}

# Virtual machines
virtual_machines = {

  example_vm1 = {
    resource_group_key = "vm_region1"
    provision_vm_agent = true
    os_type = "windows"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "example_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        net_key                 = "vnet_region1"
        subnet_key              = "example"
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
      }
    }

    virtual_machine_settings = {
      windows = {
        name = "example_vm3"
        size = "Standard_F2"
        zone = "1"

        admin_username_key = "vmadmin-username"
        admin_password_key = "vmadmin-password"

        # Spot VM to save money
        priority        = "Spot"
        eviction_policy = "Deallocate"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "example_vm1-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
          managed_disk_type    = "StandardSSD_LRS"
          disk_size_gb         = "128"
          create_option        = "FromImage"
        }

        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2019-Datacenter"
          version   = "latest"
        }

      }
    }

    virtual_machine_extensions = {
      custom_script = {
        commandtoexecute = "<command.exe>"
        fileuris = ["<uri1>","<uri2>"]
        #optional identity to use for downloading from fileuris. Can be left out if no authentication needed for fileuris, otherwise uses:
        # - virtual machine system identity ("systemassigned"), or 
        # - user assigned identity ("userassigned")
        use_identity = "userassigned"
        #identity can be referenced by local or remote key
        managed_identity_key = "<my_managed_id>"
        lz_key = "<remote state>"
        #or provided directly with managed_identity_id
        #managed_identity_id = "<managed identity principal(object) id>" 
        #storageaccountname and storageaccountkey attributes are not implemented
      }
    }
    
  }
}

# Store output attributes into keyvault secret
dynamic_keyvault_secrets = {
  example_vm_rg1 = { # Key of the keyvault
    vmadmin-username = {
      secret_name = "vmadmin-username"
      value       = "vmadmin"
    }
    vmadmin-password = {
      secret_name = "vmadmin-password"
      value       = "Very@Str5ngP!44w0rdToChaNge#"
    }
    domain-join-username = {
      secret_name = "domain-join-username"
      value       = "domainjoinuser@contoso.com"
    }
    domain-join-password = {
      secret_name = "domain-join-password"
      value       = "MyDoma1nVery@Str5ngP!44w0rdToChaNge#"
    }
  }
}

keyvaults = {
  example_vm_rg1 = {
    name               = "vmsecretskv"
    resource_group_key = "vm_region1"
    sku_name           = "standard"
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

vnets = {
  vnet_region1 = {
    resource_group_key = "vm_region1"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.100.0/24"]
    }
    subnets = {
      example = {
        name = "examples"
        cidr = ["10.100.100.0/29"]
      }
    }

  }
}
