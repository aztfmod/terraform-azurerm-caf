
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

provider_azurerm_features_keyvault = {
  // set to true to cleanup the CI
  purge_soft_delete_on_destroy = true
}

resource_groups = {
  rg1 = {
    name   = "example-disk-cmk"
    region = "region1"
  }
}


vnets = {
  vnet1 = {
    resource_group_key = "rg1"
    vnet = {
      name          = "vm-example-vnet"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      subnet1 = {
        name = "vm-example-disk-cmk-subnet"
        cidr = ["10.100.100.0/29"]
      }
    }
  }
}

public_ip_addresses = {
  pip1 = {
    name                    = "disk-example-cmk-vm-pip"
    resource_group_key      = "rg1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

# keyvaults
keyvaults = {
  kv1 = {
    name                     = "examplesecrets"
    resource_group_key       = "rg1"
    sku_name                 = "standard"
    purge_protection_enabled = true
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  kv1 = {
    logged_in_user = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      key_permissions    = ["Decrypt", "Encrypt", "Sign", "UnwrapKey", "Verify", "WrapKey", "List", "Get", "Create", "Purge"]
    }
    disk_encryption_sets = {
      disk_encryption_set_key = "set1"
      # lz_key = "example" # for remote disk_encryption_set
      key_permissions = ["Decrypt", "Encrypt", "Sign", "UnwrapKey", "Verify", "WrapKey", "List", "Get", "Create", "Purge"]
    }
  }
}

keyvault_keys = {
  key1 = {
    keyvault_key       = "kv1"
    resource_group_key = "rg1"
    name               = "disk-key"
    key_type           = "RSA"
    key_size           = 2048
    key_opts           = ["Decrypt", "Encrypt", "Sign", "UnwrapKey", "Verify", "WrapKey"]

    # curve = ""
    # not_before_date = ""
    # expiration_date = ""
  }
}

disk_encryption_sets = {
  # dependency on key_vault_key_key
  set1 = {
    name               = "diskencryptset1"
    resource_group_key = "rg1"
    # keyvault_key = {  # If in case of remote Kevault Key
    #   lz_key = ""
    # }
    key_vault_key_key = "key1"
    keyvault = {
      # lz_key = "" # if in case of remote Keyvault
      key = "kv1"
    }
  }
}




# Virtual machines -----------------------------------------------------------------------------------------------------------
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  vm1 = {
    resource_group_key = "rg1"
    provision_vm_agent = true
    os_type            = "linux"

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
      linux = {
        name                            = "example_vm1"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Spot VM to save money
        priority        = "Spot"
        eviction_policy = "Deallocate"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "vm-example-os-disk"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"

          disk_encryption_set_key = "set1"
          # lz_key = "" # for remote disk_encryption_set
          # disk_encryption_set_id = "/subscription/xxx/id" # for disk_encryption_set_id
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

