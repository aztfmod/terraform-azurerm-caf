# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  example_vm1 = {
    resource_group_key = "primary"
    provision_vm_agent = true
    # when boot_diagnostics_storage_account_key is empty string "", boot diagnostics will be put on azure managed storage
    # when boot_diagnostics_storage_account_key is a non-empty string, it needs to point to the key of a user managed storage defined in diagnostic_storage_accounts
    # if boot_diagnostics_storage_account_key is not defined, but global_settings.resource_defaults.virtual_machines.use_azmanaged_storage_for_boot_diagnostics is true, boot diagnostics will be put on azure managed storage
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "example_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    # Option to use when BYOI (Bring your Own Interface)
    # networking_interface_ids = ["/subscriptions/<subid>/resourceGroups/<rg-name>/providers/Microsoft.Network/networkInterfaces/<nicID>"]

    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "asrr_network_region1"
        subnet_key              = "asrr_subnet"
        primary                 = true
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
        public_ip_address_key   = "public_ip_primary"
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

        #custom_data - Users can either reference a local file path or a block of code as seen below.
        # custom_data                     = "scripts/cloud-init/install-rover-tools.config"
        custom_data = <<CUSTOM_DATA
        #!/bin/bash
        echo "Execute your super awesome commands here!"
        CUSTOM_DATA

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
    data_disks = {
      data1 = {
        name                 = "server1-data1"
        storage_account_type = "Standard_LRS"
        # Only Empty is supported. More community contributions required to cover other scenarios
        create_option           = "Empty"
        disk_size_gb            = "10"
        lun                     = 1
        zones                   = ["1"]
        disk_encryption_set_key = "set1"
      }
    }
    recovery_replication = {
      name = "example-replvm1"
      resource_group_key              = "secondary"
        # resource_group = {
        #   lz_key = ""
        #   resource_group_key = ""
        # }
        recovery_vault_key              = "asr1"
        # recovery_vault = {
        #   lz_key = ""
        #   recovery_vault_key = ""
        # }
        #source_recovery_fabric_name    = ""
        source_recovery_fabric_key      = "fabric_primary"
        # replication_policy_id         = ""
        replication_policy_key          = "repl1"
        # source_protection_container_name = ""
        source_protection_container_key = "container_primary"
        target_resource_group_key       = "secondary"
        # target_resource_group = {
        #   lz_key = ""
        #   key = ""
        # }
        # target_recovery_fabric_id       = ""
        target_recovery_fabric_key      = "fabric_secondary"
        # target_protection_container_id  = ""
        target_protection_container_key = "container_secondary"
        # target_availability_set_key     = ""
        managed_os_disk = {
            storage_account = {
              key = "recovery_cache_primary"
              # lz_key = ""
            }
            target_resource_group_key   = "secondary"
            target_disk_type            = "Premium_LRS"
            target_replica_disk_type    = "Premium_LRS"
            # disk_encryption_set = {
            #   lz_key = ""
            #   disk_encryption_set_key= ""
            # }
        }
        managed_disks = {
          datadisk1= {
            disk_key = "data1"
            storage_account = {
              key = "recovery_cache_primary"
              # lz_key = ""
            }
            target_resource_group = {
              # lz_key = ""  
              key = "secondary"
              }
            target_disk_type            = "Premium_LRS"
            target_replica_disk_type    = "Premium_LRS"
            # disk_encryption_set = {
            #   lz_key = ""
            #   disk_encryption_set_key= ""
            # }
          }
        }
        network_interfaces = {
          nic0 = {
          source_interface_key = "nic0"
          # target_subnet_name = ""
          target_subnet = {
            # lz_key = ""
            vnet_key = "asrr_network_region2"
            subnet_key = "asrr_subnet"
          }
          # recovery_public_ip_address_id = ""
          recovery_public_ip_address = {
            # lz_key = ""
            key = "public_ip_secondary"
          }
          # target_static_ip = ""
          }
        }
    }
  }
}


diagnostic_storage_accounts = {
  # Stores boot diagnostic for region1
  bootdiag_region1 = {
    name                     = "bootrg1"
    resource_group_key       = "primary"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}



keyvaults = {
  example_vm_rg1 = {
    name                        = "vmlinuxakv"
    resource_group_key          = "primary"
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

keyvault_keys = {
  key1 = {
    keyvault_key       = "example_vm_rg1"
    resource_group_key = "primary"
    name               = "disk-key"
    key_type           = "RSA"
    key_size           = "2048"
    key_opts           = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]
  }
}

disk_encryption_sets = {
  set1 = {
    name               = "deskey1"
    resource_group_key = "primary"
    key_vault_key_key  = "key1"
    keyvault = {
      key = "example_vm_rg1"
    }
  }
}