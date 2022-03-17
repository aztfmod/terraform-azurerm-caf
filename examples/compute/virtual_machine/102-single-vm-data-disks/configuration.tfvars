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

  # Configuration to deploy a bastion host linux virtual machine
  bastion_host = {
    resource_group_key = "vm_sg"
    os_type            = "linux"
    keyvault_key       = "example_vm_rg1"
    # Define the number of networking cards to attach the virtual machine
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
      nic1 = {
        vnet_key   = "hub_sg"
        subnet_key = "jumpbox"
        name       = "nic1"
      }
      nic2 = {
        vnet_key   = "hub_sg"
        subnet_key = "jumpbox"
        name       = "nic2"
      }
    }

    #
    virtual_machine_settings = {
      linux = {
        name                            = "bastion"
        resource_group_key              = "vm_sg"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the primary nic
        network_interface_keys = ["nic0", "nic1"]
        keyvault_key           = "example_vm_rg1"

        os_disk = {
          name                 = "bastion-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "Canonical"
          offer     = "UbuntuServer"
          sku       = "16.04-LTS"
          version   = "latest"
        }

      }
    }

    data_disks = {
      db_data1 = {
        name                 = "bastion-db-data1"
        storage_account_type = "Standard_LRS"
        # Only Empty is supported. More community contributions required to cover other scenarios
        create_option = "Empty"
        disk_size_gb  = "10"
        lun           = 1
      }
      db_data2 = {
        name                 = "bastion-db-data2"
        storage_account_type = "Standard_LRS"
        create_option        = "Empty"
        disk_size_gb         = "10"
        lun                  = 2
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


keyvaults = {
  example_vm_rg1 = {
    name               = "vmsecrets"
    resource_group_key = "vm_sg"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}
