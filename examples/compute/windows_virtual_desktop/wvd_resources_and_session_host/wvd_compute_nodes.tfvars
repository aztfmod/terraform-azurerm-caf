availability_sets = {
  avset1 = {
    name               = "avset-wvd"
    region             = "region2"
    resource_group_key = "vm_region1"
    # Depends on the region, update and fault domain count availability varies.
    platform_update_domain_count = 2
    platform_fault_domain_count  = 2
    # By default availability set is configured as managed. Below can be used to change it to unmanged.
    # managed                      = false
  }
}

# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  example_vm1 = {
    region             = "region2"
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
        subnet_key              = "wvd_hosts"
        name                    = "nic0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0-vm7"
      }
    }

    virtual_machine_settings = {
      windows = {
        name                 = "example_vm12"
        size                 = "Standard_F2s"
        availability_set_key = "avset1"

        admin_username_key = "vmadmin-username"
        admin_password_key = "vmadmin-password"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "example_vm1-os"
          caching              = "ReadWrite"
          storage_account_type = "StandardSSD_LRS"
          managed_disk_type    = "StandardSSD_LRS"
          disk_size_gb         = "128"
          create_option        = "FromImage"
        }

        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2016-Datacenter"
          version   = "latest"
        }
      }
    }

    ## REQUIRED EXTENSIONS FOR WVD SESSION HOSTS

    virtual_machine_extensions = {
      microsoft_azure_domainjoin = {
        domain_name = "contoso.com"
        ou_path     = ""
        restart     = "true"
        #specify the AKV location of the password to retrieve for domain join operation
        domain_join_password_keyvault = {
          keyvault_key = "example_vm_rg1"
          secret_name  = "domain-join-password"
        }
        domain_join_username_keyvault = {
          keyvault_key = "example_vm_rg1"
          secret_name  = "domain-join-username"
        }
      }
      session_host_dscextension = {
        host_pool = {
          host_pool_key = "wvd_hp1"
          keyvault_key  = "host_pool_secrets"
          secret_name   = "newwvd-hostpool-token"
          # lz_key        = "examples"
        }
        base_url = "https://raw.githubusercontent.com/Azure/RDS-Templates/master/ARM-wvd-templates"
      }
    }
  }
}
