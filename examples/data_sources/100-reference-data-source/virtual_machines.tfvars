
# Virtual machines

#
# Deploy a new Virtual Machine into an existing Resource Group, Virtual Network and Subnet, Key Vault and Recovery Vault
#

virtual_machines = {

  vm1 = {
    region             = "australiaeast"
    resource_group_key = "my_rg"
    provision_vm_agent = true
    tags = {
      environment = "dev"
      team        = "IT"
    }

    os_type      = "windows"
    keyvault_key = "existing_keyvault"

    backup = {
      vault_key  = "existing_recovery_vault"
      policy_key = "DefaultPolicy"
    }

    networking_interfaces = {
      nic0 = {
        vnet_key                      = "vnet_existing" # When commented subnet_key will user virtuel_subnets
        subnet_key                    = "default"
        name                          = "0"
        enable_ip_forwarding          = false
        internal_dns_name_label       = "nic0"
        enable_accelerated_networking = "true"
      }
    }

    virtual_machine_settings = {
      windows = {
        name           = "Merck-vm1"
        size           = "Standard_D4s_v3"
        admin_username = "adminuser"
        zone           = "1"

        network_interface_keys = ["nic0"]
        os_disk = {
          name                 = "Merck-vm1-os"
          caching              = "ReadWrite"
          storage_account_type = "Premium_LRS"
        }
        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2019-Datacenter"
          version   = "latest"
        }
      }
    }

    data_disks = {
      db_data1 = {
        name                 = "datavm1"
        storage_account_type = "Premium_LRS"
        create_option        = "Empty"
        disk_size_gb         = "128"
        lun                  = 1
        zones                = ["1"]
      }
    }
  }

}