global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
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

# managed identity to attach to vm to download from the storage account
managed_identities = {
  user_mi = {
    name               = "user_mi"
    resource_group_key = "vm_region1"
  }
}

storage_accounts = {
  sa1 = {
    name               = "sa1"
    resource_group_key = "vm_region1"
    # Account types are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2
    #account_kind = "BlobStorage"
    # Account Tier options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    account_tier = "Standard"
    #  Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS
    account_replication_type = "LRS" # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    containers = {
      files = {
        name = "files"
      }
    }
  }
}

# upload helloworld script
storage_account_blobs = {
  script = {
    name                   = "helloworld.ps1"
    storage_account_key    = "sa1"
    storage_container_name = "files"
    source                 = "./compute/virtual_machine/110-single-windows-vm-custom-script-extension/helloworld.ps1"
    parallelism            = 1
  }
}

# give managed identity Storage Blob Data reader and executing user Storage Blob Data Contributor permissions on storage account
role_mapping = {
  built_in_role_mapping = {
    storage_accounts = {
      sa1 = {
        "Storage Blob Data Reader" = {
          managed_identities = {
            keys = ["user_mi"]
          }
        }
        "Storage Blob Data Contributor" = {
          logged_in = {
            keys = ["user"]
          }
        }
      }
    }
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

    os_type = "windows"

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
        internal_dns_name_label = "nic0"
      }
    }
    virtual_machine_extensions = {
      custom_script = {
        #fileuris            = ["https://somelocation/container/script.ps1"]
        # can define fileuris directly or use fileuri_sa_ reference keys and lz_key:
        fileuri_sa_key   = "sa1"
        fileuri_sa_path  = "files/helloworld.ps1"
        commandtoexecute = "PowerShell -file helloworld.ps1"
        # managed_identity_id = optional to define managed identity principal_id directly
        identity_type        = "UserAssigned" #optional to use managed_identity for download from location specified in fileuri, UserAssigned or SystemAssigned. 
        managed_identity_key = "user_mi"
        #lz_key               = "other_lz" optional for managed identity defined in other lz 
      }
    }
    virtual_machine_settings = {
      windows = {
        name = "example_cse"
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
        identity = { #assign managed identity to the vm
          type                  = "UserAssigned"
          managed_identity_keys = ["user_mi"]
        }
      }
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
  }
}