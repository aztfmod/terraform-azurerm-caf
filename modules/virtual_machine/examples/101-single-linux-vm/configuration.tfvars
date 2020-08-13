location = "southeastasia"

resource_groups = {
  vm_sg = {
    name       = "test-vm-sg"
    location   = "southeastasia"
    useprefix  = true
    max_length = 40
  }
}


# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  bastion_host = {
    resource_group_key = "vm_sg"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "hub_sg"
        subnet_key              = "jumpbox"
        name                    = "nic0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
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

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

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

  }
}

## Networking configuration
networking = {
  hub_sg = {
    resource_group_key = "vm_sg"
    location           = "southeastasia"
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