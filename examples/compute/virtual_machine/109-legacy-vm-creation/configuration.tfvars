global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}


resource_groups = {
  vm_sg = {
    name      = "test-vm-sg"
    location  = "australiaeast"
    useprefix = true
  }
  vnet_sg = {
    name      = "test-networking-sg"
    location  = "australiaeast"
    useprefix = true
  }
}

# Virtual machines
virtual_machines = {

  vm_1 = {
    tags = {
      env = "dev"
    }
    resource_group_key = "vm_sg"

    os_type      = "legacy"
    keyvault_key = "example_vm_rg1"

    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key   = "hub_sg"
        subnet_key = "jumpbox"
        # public_address_key = ""
        name                    = "nic0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
      }
    }

    virtual_machine_settings = {
      legacy = {
        name               = "vm_1"
        resource_group_key = "vm_sg"
        size               = "Standard_E48s_v3"
        admin_username     = "cloud-user"
        #zones = ""
        delete_os_disk_on_termination    = true
        delete_data_disks_on_termination = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                  = "vm_1-os"
          caching               = "ReadWrite"
          disk_size_gb          = "64"
          create_option         = "FromImage"
          operating_system_type = "Linux"
        }

        os_profile_linux_config = {
          disable_password_authentication = true
        }

        source_image_reference = {
          #publisher = "Canonical"
          #offer     = "UbuntuServer"
          #sku       = "16.04-LTS"
          #version   = "latest"
          custom_image_id = "some_image_id"
        }

        plan = {
          name      = "rhel-lvm84-gen2"
          product   = "rhel-byos"
          publisher = "redhat"
        }

        storage_data_disk = {
          lun0 = {
            name          = "vm_1-lun0"
            create_option = "FromImage"
            disk_size_gb  = "65"
            lun           = 0
            caching       = "ReadWrite"
          }
          lun1 = {
            name              = "vm_1-lun1"
            create_option     = "FromImage"
            disk_size_gb      = "65"
            lun               = 1
            caching           = "ReadWrite"
            managed_disk_type = "Premium_LRS"
          }
          lun2 = {
            name          = "vm_1-lun2"
            create_option = "FromImage"
            disk_size_gb  = "65"
            lun           = 2
            caching       = "ReadWrite"
          }
        }
      }
    }
  },
  vm_2 = {
    tags = {
      env = "dev"
    }
    resource_group_key = "vm_sg"

    os_type      = "legacy"
    keyvault_key = "example_vm_rg1"

    networking_interfaces = {
      nic1 = {
        # Value of the keys from networking.tfvars
        vnet_key   = "hub_sg"
        subnet_key = "jumpbox"
        # public_address_key = ""
        name                    = "nic1"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic1"
      }
    }

    virtual_machine_settings = {
      legacy = {
        name                             = "vm_2"
        resource_group_key               = "vm_sg"
        size                             = "Standard_E48s_v3"
        admin_username_key               = "vmadmin-username"
        admin_password_key               = "vmadmin-password"
        delete_os_disk_on_termination    = true
        delete_data_disks_on_termination = true
        license_type                     = "Windows_Server"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic1"]

        os_disk = {
          name                  = "vm_2-os"
          caching               = "ReadWrite"
          disk_size_gb          = "127"
          create_option         = "FromImage"
          operating_system_type = "Windows"
        }

        os_profile_windows_config = {
          provision_vm_agent        = true
          enable_automatic_upgrades = true
          timezone                  = "Central Standard Time"
          #winrm = {
          #  winrm_1 = {
          #  protocol = "HTTPS"
          #  }
          #}
          #additional_unattend_config = {
          #  additional_unattend_config_1 = {
          #    pass = "oobeSystem"
          #    component = "Microsoft-Windows-Shell-Setup"
          #    setting_name = "FirstLogonCommands"
          #    content = "idk"
          #  }
          #}
        }

        #additional_capabilities = {
        #  ultra_ssd_enabled = true
        #}

        #winrm = {
        #  enable_self_signed = true
        #}

        storage_image_reference = {
          #publisher = "MicrosoftWindowsServer"
          #offer     = "WindowsServer"
          #sku       = "2019-Datacenter"
          #version   = "latest"
          custom_image_id = "some_image_id"
        }

        storage_data_disk = {
          lun0 = {
            name          = "vm_2-lun0"
            create_option = "Empty"
            disk_size_gb  = "65"
            lun           = 0
            caching       = "ReadWrite"
          }
          lun1 = {
            name              = "vm_2-lun1"
            create_option     = "Empty"
            disk_size_gb      = "65"
            lun               = 1
            caching           = "ReadWrite"
            managed_disk_type = "Premium_LRS"
          }
          lun2 = {
            name          = "vm_2-lun2"
            create_option = "Empty"
            disk_size_gb  = "65"
            lun           = 2
            caching       = "ReadWrite"
          }
          lun3 = {
            name          = "vm_2-lun3"
            create_option = "Empty"
            disk_size_gb  = "65"
            lun           = 2
            caching       = "ReadWrite"
          }
        }
      }
    }
  }
}

## Networking configuration
vnets = {
  hub_sg = {
    resource_group_key = "vnet_sg"
    location           = "australiaeast"
    vnet = {
      name          = "hub"
      address_space = ["10.10.100.0/24"]
    }
    specialsubnets = {
    }
    subnets = {
      jumpbox = {
        name     = "jumpbox"
        cidr     = ["10.10.100.0/25"]
        nsg_name = "jumpbox_nsg"
        nsg      = []
      }

    }
    diags = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["VMProtectionAlerts", true, true, 60],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, true, 60],
      ]
    }
  }
}

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
    domain-join-username = {
      secret_name = "domain-join-username"
      value       = "domainjoinuser@contoso.com"
    }
    domain-join-password = {
      secret_name = "domain-join-password"
      value       = "MyDoma1nVery@Str5ngP!44w0rdToChaNge#"
    }
  }
}

keyvaults = {
  example_vm_rg1 = {
    name               = "vmsecrets"
    resource_group_key = "vm_sg"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}


