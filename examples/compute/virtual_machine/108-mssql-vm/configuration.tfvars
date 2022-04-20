global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  rg1 = {
    name = "mssql-vm-rg"
  }
}

storage_accounts = {
  sa1 = {
    name                     = "backupsa"
    resource_group_key       = "rg1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

keyvaults = {
  kv1 = {
    name                     = "vmsecretskv"
    resource_group_key       = "rg1"
    sku_name                 = "standard"
    soft_delete_enabled      = true
    purge_protection_enabled = false
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

vnets = {
  vnet1 = {
    resource_group_key = "rg1"
    vnet = {
      name          = "mssqlvm"
      address_space = ["10.100.0.0/16"]
    }
    specialsubnets = {}
    subnets = {
      subnet1 = {
        name = "compute"
        cidr = ["10.100.1.0/24"]
      }
    }

  }
}


public_ip_addresses = {
  pip1 = {
    name                    = "pip1"
    resource_group_key      = "rg1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }
}

# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  example_vm1 = {
    resource_group_key = "rg1"
    provision_vm_agent = true
    # when boot_diagnostics_storage_account_key is empty string "", boot diagnostics will be put on azure managed storage
    # when boot_diagnostics_storage_account_key is a non-empty string, it needs to point to the key of a user managed storage defined in diagnostic_storage_accounts
    # if boot_diagnostics_storage_account_key is not defined, but global_settings.resource_defaults.virtual_machines.use_azmanaged_storage_for_boot_diagnostics is true, boot diagnostics will be put on azure managed storage
    boot_diagnostics_storage_account_key = ""

    os_type = "windows"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "kv1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "vnet1"
        subnet_key              = "subnet1"
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
        public_ip_address_key   = "pip1"
      }
    }

    virtual_machine_settings = {
      windows = {
        name = "mssqlvm"
        size = "Standard_D4as_v4"
        zone = "1"

        admin_username = "azadminuser"

        # admin_username_key = "vmadmin-username"
        # admin_password_key = "vmadmin-password"

        # Spot VM to save money
        priority        = "Spot"
        eviction_policy = "Deallocate"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "osdisk"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
          managed_disk_type    = "StandardSSD_LRS"
          disk_size_gb         = "128"
          create_option        = "FromImage"
        }
        source_image_reference = {
          publisher = "MicrosoftSQLServer"
          offer     = "SQL2017-WS2016"
          sku       = "SQLDEV"
          version   = "latest"
        }

        mssql_settings = { # requires SQL Image in source_image_reference
          sql_license_type      = "PAYG"
          r_services_enabled    = true
          sql_connectivity_port = 1433
          sql_connectivity_type = "PRIVATE"

          sql_authentication = {
            sql_credential = {
              # lz_key           = ""
              keyvault_key = "kv1"
              sql_username = "sqllogin"
              # sql_password_secret_name = "" # custom kv secret name for sql user password
              # sql_username_key = "sql-username" # existing kv secret name for reference
              # sql_password_key = "sql-password" # existing kv secret name for password reference, if not specified, password will be auto-generated
            }

            # keyvault_credential = {
            #   name = "sqlkv_credentials"
            #   # lz_key       = ""
            #   keyvault_key = "sql_cred_kv" # get url from here
            #   service_principal_secrets = { # sp secret to access the kv above
            #     # lz_key = ""
            #     keyvault_key = "sp_secrets" # get url from here
            #     sp_client_id_key = "sp-client-id"
            #     sp_client_secret_key = "sp-client-secret"
            #   }
            # }
          }

          auto_patching = {
            day_of_week                            = "Sunday"
            maintenance_window_duration_in_minutes = 60
            maintenance_window_starting_hour       = 2
          }
          auto_backup = {
            # DEPLOYMENT NOTE: To apply this using auto-generated password, the module should be deployed with the encryption_password block commented first. Then re-apply with the block uncommented

            # encryption_password = { # comment this block if encryption is not needed
            #   # lz_key = ""
            #   keyvault_key = "kv1"
            #   # encryption_password_secret_name = "" # custom kv secret name for auto-generated password
            #   # encryption_password_key = "" existing kv secret name for password reference, if not specified, password will be auto-generated
            # }
            retention_period_in_days = 7
            storage_account = {
              # lz_key = ""
              key = "sa1"
            }
            manual_schedule = {
              full_backup_frequency           = "Weekly" # Daily / Weekly
              full_backup_start_hour          = 0        # 0 - 23
              full_backup_window_in_hours     = 1        # 1 - 23
              log_backup_frequency_in_minutes = 60       # 5 - 60f
            }

          }


          storage_configuration = {
            disk_type             = "NEW"     # NEW, EXTEND, ADD
            storage_workload_type = "GENERAL" # GENERAL, OLTP, DW

            data_settings = {
              default_file_path = "F:\\data"
              luns              = [1]
            }
          }

        }

      }
    }
    data_disks = {
      data1 = {
        name                 = "datadisk1"
        storage_account_type = "Premium_LRS"
        create_option        = "Empty"
        disk_size_gb         = "10"
        lun                  = 1
        zones                = ["1"]
      }
    }

  }
}
