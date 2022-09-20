virtual_machines = {
  # VM with user assigned identity
  vm1 = {
    resource_group_key = "rg1"
    os_type            = "windows"
    # credentials stored in the keyvault defined in keyvaults.tfvars
    keyvault_key = "kv1"
    networking_interfaces = {
      # use vnet and public ip defined in networking.tfvars
      nic0 = {
        vnet_key                = "vnet1"
        subnet_key              = "default"
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
        public_ip_address_key   = "pip1"
      }
    }
    virtual_machine_extensions = {
      # auto-install certificates from keyvault onto Windows
      keyvault_for_windows = {
        # map of objects defining certificates in key vaults
        # the map keys do NOT need to be the name of the certificate, it just makes things easier to read
        certificates = {
          "demoapp1-cafdemo-com" = {
            # reference remote landing zone if needed (for this example we are pulling from kv in local lz so it's commented out)
            # lz_key = "remotelzkey"
            # pull from kv defined in local lz
            keyvault_key = "kv1"
            # alternative method of pointing to key vault via resource id (no need to define lz_key or keyvault_key)
            # key_vault_id = "/subscriptions/<subscription id>/resourceGroups/<resource group name>/providers/Microsoft.KeyVault/vaults/<name of key vault>"

            # name of the certificate to pull from keyvault
            name = "demoapp1-cafdemo-com"
          }
          "demoapp2-cafdemo-com" = {
            keyvault_key = "kv1"
            name         = "demoapp2-cafdemo-com"
          }
        }
        # optional extension properties (with default values shown)
        # see extension docs for more detail: https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/key-vault-windows
        # recommend you exclude these for brevity, they are in this example for completeness
        type_handler_version       = "1.0"
        auto_upgrade_minor_version = true
        polling_interval_in_s      = "3600"
        link_on_renewal            = false
        require_initial_sync       = true
        certificate_store_name     = "My"
        certificate_store_location = "LocalMachine"
      }
    }
    virtual_machine_settings = {
      windows = {
        name = "vm1"
        size = "Standard_F2"
        # use admin credentials from keyvault
        admin_username_key = "admin-username"
        admin_password_key = "admin-password"
        # very important this vm be associated with a managed identity that has get/list policy on keyvault certs
        identity = {
          type                  = "UserAssigned"
          managed_identity_keys = ["vm_msi"]
        }
        priority               = "Spot"
        eviction_policy        = "Deallocate"
        network_interface_keys = ["nic0"]
        os_disk = {
          name                 = "vm1-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }
        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2019-Datacenter"
          version   = "latest"
        }
      }
    }
  }
}