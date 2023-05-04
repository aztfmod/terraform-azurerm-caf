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
  rg1 = {
    name = "vmss-lb-cse-rg"
  }
}

managed_identities = {
  example_mi = {
    name               = "example_mi"
    resource_group_key = "rg1"
  }
}

storage_accounts = {
  sa1 = {
    name               = "sa1"
    resource_group_key = "rg1"
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

# Give managed identity Storage Blob Data reader and executing user Storage Blob Data Contributor permissions on storage account
role_mapping = {
  built_in_role_mapping = {
    storage_accounts = {
      sa1 = {
        "Storage Blob Data Reader" = {
          managed_identities = {
            keys = ["example_mi"]
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

vnets = {
  vnet1 = {
    resource_group_key = "rg1"
    vnet = {
      name          = "vmss"
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

keyvaults = {
  example_kv_rg1 = {
    name               = "example_kv_rg1"
    resource_group_key = "rg1"
    sku_name           = "standard"
    tags = {
      env = "Standalone"
    }
    creation_policies = {
      logged_in_user = {
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
        certificate_permissions = ["Get", "Create", "Delete", "Purge"]
      }
    }
  }
}

# Store output attributes into keyvault secret
dynamic_keyvault_secrets = {
  example_kv_rg1 = { # Key of the keyvault
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

keyvault_certificates = {
  "example.selfsignedcert.com" = {

    keyvault_key = "example_kv_rg1"
    # lz_key       = ""

    # may only contain alphanumeric characters and dashes
    name = "selfsignedcert"

    subject            = "CN=example.selfsignedcert.com"
    validity_in_months = 12

    subject_alternative_names = {
      #  A list of alternative DNS names (FQDNs) identified by the Certificate.
      # Changing this forces a new resource to be created.
      dns_names = [
        "example.selfsignedcert.com"
      ]

      # A list of email addresses identified by this Certificate.
      # Changing this forces a new resource to be created.
      # emails = []

      # A list of User Principal Names identified by the Certificate.
      # Changing this forces a new resource to be created.
      # upns = []
    }

    tags = {
      type = "SelfSigned"
    }

    # Possible values include Self (for self-signed certificate),
    # or Unknown (for a certificate issuing authority like Let's Encrypt
    # and Azure direct supported ones).
    # Changing this forces a new resource to be created
    issuer_parameters = "Self"

    exportable = true

    # Possible values include 2048 and 4096.
    # Changing this forces a new resource to be created.
    key_size  = 4096
    key_type  = "RSA"
    reuse_key = true

    # The Type of action to be performed when the lifetime trigger is triggered.
    # Possible values include AutoRenew and EmailContacts.
    # Changing this forces a new resource to be created.
    action_type = "AutoRenew"

    # The number of days before the Certificate expires that the action
    # associated with this Trigger should run.
    # Changing this forces a new resource to be created.
    # Conflicts with lifetime_percentage
    days_before_expiry = 30

    # The percentage at which during the Certificates Lifetime the action
    # associated with this Trigger should run.
    # Changing this forces a new resource to be created.
    # Conflicts with days_before_expiry
    # lifetime_percentage = 90

    # The Content-Type of the Certificate, such as application/x-pkcs12 for a PFX
    # or application/x-pem-file for a PEM.
    # Changing this forces a new resource to be created.
    content_type = "application/x-pkcs12"

    # A list of uses associated with this Key.
    # Possible values include
    # cRLSign, dataEncipherment, decipherOnly,
    # digitalSignature, encipherOnly, keyAgreement, keyCertSign,
    # keyEncipherment and nonRepudiation
    # and are case-sensitive.
    # Changing this forces a new resource to be created
    key_usage = [
      "cRLSign",
      "dataEncipherment",
      "digitalSignature",
      "keyAgreement",
      "keyCertSign",
      "keyEncipherment",
    ]
  }
}

diagnostic_storage_accounts = {
  # Stores boot diagnostic for region1
  bootdiag1 = {
    name                     = "lebootdiag1"
    resource_group_key       = "rg1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}

# Application security groups
application_security_groups = {
  app_sg1 = {
    resource_group_key = "rg1"
    name               = "app_sg1"
  }
}

# Load Balancer
public_ip_addresses = {
  lb_pip1 = {
    name               = "lb_pip1"
    resource_group_key = "rg1"
    sku                = "Basic"
    # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    allocation_method = "Dynamic"
    # allocation method needs to be Dynamic
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
  lb_pip2 = {
    name               = "lb_pip2"
    resource_group_key = "rg1"
    sku                = "Basic"
    # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    allocation_method = "Dynamic"
    # allocation method needs to be Dynamic
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

# Public Load Balancer will be created. For Internal/Private Load Balancer config, please refer 102-internal-load-balancer example.
load_balancers = {
  lb1 = {
    name                      = "lb-vmss"
    sku                       = "basic"
    resource_group_key        = "rg1"
    backend_address_pool_name = "vmss1"
    frontend_ip_configurations = {
      config1 = {
        name                  = "config1"
        public_ip_address_key = "lb_pip1"
      }
    }
  }
  lb2 = {
    name                      = "lb-vmss2"
    sku                       = "basic"
    resource_group_key        = "rg1"
    backend_address_pool_name = "vmss1"
    frontend_ip_configurations = {
      config1 = {
        name                  = "config1"
        public_ip_address_key = "lb_pip2"
      }
    }
  }
}

virtual_machine_scale_sets = {
  vmss1 = {
    resource_group_key                   = "rg1"
    boot_diagnostics_storage_account_key = "bootdiag1"
    os_type                              = "linux"
    keyvault_key                         = "example_kv_rg1"

    vmss_settings = {
      linux = {
        name                            = "linux_vmss1"
        computer_name_prefix            = "lnx"
        sku                             = "Standard_F2"
        instances                       = 1
        admin_username                  = "adminuser"
        disable_password_authentication = true
        provision_vm_agent              = true
        priority                        = "Spot"
        eviction_policy                 = "Deallocate"
        ultra_ssd_enabled               = false # required if planning to use UltraSSD_LRS

        upgrade_mode = "Manual" # Automatic / Rolling / Manual

        # rolling_upgrade_policy = {
        #   # Only for upgrade mode = "Automatic / Rolling "
        #   max_batch_instance_percent = 20
        #   max_unhealthy_instance_percent = 20
        #   max_unhealthy_upgraded_instance_percent = 20
        #   pause_time_between_batches = ""
        # }
        # automatic_os_upgrade_policy = {
        #   # Only for upgrade mode = "Automatic"
        #   disable_automatic_rollback = false
        #   enable_automatic_os_upgrade = true
        # }

        os_disk = {
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
          disk_size_gb         = 128
          # disk_encryption_set_key = ""
          # lz_key = ""
        }

        identity = {
          # type = "SystemAssigned"
          type                  = "UserAssigned"
          managed_identity_keys = ["example_mi"]

          remote = {
            lz_key_name = {
              managed_identity_keys = []
            }
          }
        }

        # custom_image_id = ""

        source_image_reference = {
          publisher = "Canonical"
          offer     = "UbuntuServer"
          sku       = "18.04-LTS"
          version   = "latest"
        }

      }
    }

    network_interfaces = {
      # option to assign each nic to different LB/ App GW

      nic0 = {

        name       = "0"
        primary    = true
        vnet_key   = "vnet1"
        subnet_key = "subnet1"
        load_balancers = {
          lb1 = {
            lb_key = "lb1"
            # lz_key = ""
          }
        }

        application_security_groups = {
          asg1 = {
            asg_key = "app_sg1"
            # lz_key = ""
          }
        }

        enable_accelerated_networking = false
        enable_ip_forwarding          = false
        internal_dns_name_label       = "nic0"
      }
    }

    data_disks = {
      data1 = {
        caching                   = "None"  # None / ReadOnly / ReadWrite
        create_option             = "Empty" # Empty / FromImage (only if source image includes data disks)
        disk_size_gb              = "10"
        lun                       = 1
        storage_account_type      = "Standard_LRS" # UltraSSD_LRS only possible when > additional_capabilities { ultra_ssd_enabled = true }
        disk_iops_read_write      = 100            # only for UltraSSD Disks
        disk_mbps_read_write      = 100            # only for UltraSSD Disks
        write_accelerator_enabled = false          # true requires Premium_LRS and caching = "None"
        # disk_encryption_set_key = "set1"
        # lz_key = "" # lz_key for disk_encryption_set_key if remote
      }
    }

    # virtual_machine_scale_set_extensions = {
    #   microsoft_azure_domainjoin = {
    #     domain_name = "test.local"
    #     ou_path     = "OU=test,DC=test,DC=local"
    #     restart     = "true"
    #     # specify the AKV location of the password to retrieve for domain join operation
    #     domain_join_username_keyvault = {
    #       keyvault_key = "vmsecretskv"
    #       #key_vault_id = ""
    #       #lz_key       = ""
    #       secret_name = "domjoinuser"
    #     }
    #     domain_join_password_keyvault = {
    #       keyvault_key = "vmsecretskv"
    #       #key_vault_id = ""
    #       #lz_key       = ""
    #       secret_name = "domjoinpassword"
    #     }
    #   }
    # }

  }

  vmss2 = {
    resource_group_key                   = "rg1"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag1"
    os_type                              = "windows"
    keyvault_key                         = "example_kv_rg1"

    vmss_settings = {
      windows = {
        name                            = "win"
        computer_name_prefix            = "win"
        sku                             = "Standard_F2"
        instances                       = 1
        admin_username                  = "adminuser"
        disable_password_authentication = true
        priority                        = "Spot"
        eviction_policy                 = "Deallocate"

        upgrade_mode = "Manual" # Automatic / Rolling / Manual

        # rolling_upgrade_policy = {
        #   # Only for upgrade mode = "Automatic / Rolling "
        #   max_batch_instance_percent = 20
        #   max_unhealthy_instance_percent = 20
        #   max_unhealthy_upgraded_instance_percent = 20
        #   pause_time_between_batches = ""
        # }
        # automatic_os_upgrade_policy = {
        #   # Only for upgrade mode = "Automatic"
        #   disable_automatic_rollback = false
        #   enable_automatic_os_upgrade = true
        # }

        os_disk = {
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
          disk_size_gb         = 128
        }

        identity = {
          type                  = "SystemAssigned"
          managed_identity_keys = []
        }

        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2016-Datacenter"
          version   = "latest"
        }

      }
    }

    network_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        name       = "0"
        primary    = true
        vnet_key   = "vnet1"
        subnet_key = "subnet1"

        load_balancers = {
          lb2 = {
            lb_key = "lb2"
            # lz_key = ""
          }
        }

        application_security_groups = {
          asg1 = {
            asg_key = "app_sg1"
            # lz_key = ""
          }
        }

        enable_accelerated_networking = false
        enable_ip_forwarding          = false
        internal_dns_name_label       = "nic0"
      }
    }
    ultra_ssd_enabled = false # required if planning to use UltraSSD_LRS

    data_disks = {
      data1 = {
        caching                   = "None"  # None / ReadOnly / ReadWrite
        create_option             = "Empty" # Empty / FromImage (only if source image includes data disks)
        disk_size_gb              = "10"
        lun                       = 1
        storage_account_type      = "Standard_LRS" # UltraSSD_LRS only possible when > additional_capabilities { ultra_ssd_enabled = true }
        disk_iops_read_write      = 100            # only for UltraSSD Disks
        disk_mbps_read_write      = 100            # only for UltraSSD Disks
        write_accelerator_enabled = false          # true requires Premium_LRS and caching = "None"
        # disk_encryption_set_key = "set1"
        # lz_key = "" # lz_key for disk_encryption_set_key if remote
      }
    }

    virtual_machine_scale_set_extensions = {
      microsoft_azure_keyvault = {
        identity_type        = "UserAssigned"
        managed_identity_key = "example_mi"
        # managed_identity_id  = "" # optional : add manual id
        # lz_key               = ""
        secrets_management_settings = {
          # key_vault_id             = ""               # optional: manually enter the id of the keyvault
          # lz_key                   = "shared_storage" # optional: add lz_key if keyvault exists in a different landingzone
          key_vault_key            = "example_kv_rg1" # key of the keyvault (created in the current or other landingzone)
          certificateStoreName     = "selfsignedcert"
          certificateStoreLocation = "LocalMachine" # LocalMachine or CurrentUser (case sensitive)
          requireInitialSync       = true
          # observedCertificates     = ["https://<kv-name>.vault.azure.net/secrets/certificates/webselfsigned"] # one or more urls ["url1", "url2"] or empty (if manual, put /secrets in the path, it returns the full certificate)
          # linkOnRenewal            = false
          # pollingIntervalInS       = "3600"
        }
        # Optional manual auth settings
        # authenticationSettings = {
        #   msiEndpoint = "http://169.254.169.254/metadata/identity"
        #   msiClientId = "<client-id>"
        # }
      }
    }
  }
}
