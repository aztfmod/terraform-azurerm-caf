global_settings = {
  default_region = "region1"
  prefix         = null
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  rg1 = {
    name = "example-vmss-rg"
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
  kv1 = {
    name               = "vmsskv"
    resource_group_key = "rg1"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}


diagnostic_storage_accounts = {
  # Stores boot diagnostic for region1
  bootdiag1 = {
    name                     = "vmssbootdiag1"
    resource_group_key       = "rg1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}

virtual_machine_scale_sets = {
  vmss1 = {
    resource_group_key = "rg1"
    provision_vm_agent = true
    boot_diagnostics_storage_account_key = "bootdiag1"
  

    os_type = "linux"

    keyvault_key = "kv1"

    vmss_settings = {
      linux = {
        name = "linux_vmss1"
        sku = "Standard_F2"
        instances = 2
        admin_username = "adminuser"
        disable_password_authentication = true
        priority = "Spot"
        eviction_policy = "Deallocate"        

        networking_interfaces = {
          nic0 = {
            name = "0"
            primary = true
            vnet_key = "vnet1"
            subnet_key = "subnet1"
          }
        }

        os_disk = {
          caching = "ReadWrite"
          storage_account_type = "Standard_LRS"
          disk_size_gb = 128
        }

        identity = {
          type = "SystemAssigned"
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