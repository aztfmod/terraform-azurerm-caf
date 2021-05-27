# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  bastion_host = {
    resource_group_key = "vm_region1"
    provision_vm_agent = true
    # when boot_diagnostics_storage_account_key is empty string "", boot diagnostics will be put on azure managed storage
    # when boot_diagnostics_storage_account_key is a non-empty string, it needs to point to the key of a user managed storage defined in diagnostic_storage_accounts
    # if boot_diagnostics_storage_account_key is not defined, but global_settings.resource_defaults.virtual_machines.use_azmanaged_storage_for_boot_diagnostics is true, boot diagnostics will be put on azure managed storage
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "ssh_keys"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "vnet_region1"
        subnet_key              = "bastion"
        name                    = "0-bastion_host"
        enable_ip_forwarding    = false
        internal_dns_name_label = "bastion-host-nic0"
        public_ip_address_key   = "bastion_host_pip1"

        networking_interface_asg_associations = {
          bastion = {
            key = "bastion"
          }
        }
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "bastion_host"
        size                            = "Standard_F2s"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        zone = "1"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "bastion_host-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "canonical"
          offer     = "0001-com-ubuntu-server-focal"
          sku       = "20_04-lts"
          version   = "latest"
        }

      }
    }

  }

  windows_server1 = {
    resource_group_key = "vm_region1"
    # when boot_diagnostics_storage_account_key is empty string "", boot diagnostics will be put on azure managed storage
    # when boot_diagnostics_storage_account_key is a non-empty string, it needs to point to the key of a user managed storage defined in diagnostic_storage_accounts
    # if boot_diagnostics_storage_account_key is not defined, but global_settings.resource_defaults.virtual_machines.use_azmanaged_storage_for_boot_diagnostics is true, boot diagnostics will be put on azure managed storage
    boot_diagnostics_storage_account_key = "bootdiag_region1"
    provision_vm_agent                   = true

    os_type = "windows"


    # when not set the password is auto-generated and stored into the keyvault
    keyvault_key = "ssh_keys"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        vnet_key                = "vnet_region1"
        subnet_key              = "servers"
        name                    = "0-server1"
        enable_ip_forwarding    = false
        internal_dns_name_label = "server1-nic0"

        network_security_group = {
          key = "data"
        }

        networking_interface_asg_associations = {
          app_server = {
            key = "app_server"
          }
        }
      }
    }



    virtual_machine_settings = {
      windows = {
        name           = "server1"
        size           = "Standard_F2s_v2"
        admin_username = "adminuser"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        zone = "1"

        os_disk = {
          name                 = "server1-os"
          caching              = "ReadWrite"
          create_option        = "FromImage"
          storage_account_type = "Standard_LRS"
          managed_disk_type    = "StandardSSD_LRS"
          disk_size_gb         = "128"
        }

        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2019-Datacenter"
          version   = "latest"
        }

        winrm = {
          enable_self_signed = true
        }

      }
    }

    # data_disks = {
    #   data1 = {
    #     name                 = "server1-data1"
    #     storage_account_type = "Standard_LRS"
    #     # Only Empty is supported. More community contributions required to cover other scenarios
    #     create_option = "Empty"
    #     disk_size_gb  = "10"
    #     lun           = 1
    #     zones         = ["1"]
    #   }
    # }

  }
}
