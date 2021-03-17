application_security_groups = {
  bastion = {
    name = "bastionappsecgw1"
    resource_group_key = "vm_region1"
        
  }

  workloads = {
    name = "workloadsappsecgw1"
    resource_group_key = "vm_region1"
    
  }
}

networking_interface_asg_associations = {
  nic0 = {
    application_security_group_key = "bastion"
    resource_group_key = "vm_region1"
    vm_key  = "bastion_host"
    nic_key = "nic0"
  }
  nic1 = {
    application_security_group_key = "bastion"
    resource_group_key = "vm_region1"
    vm_key  = "bastion_host"
    nic_key = "nic1"
  }
}

virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  bastion_host = {
    resource_group_key                   = "vm_region1"
    provision_vm_agent                   = true
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
      }
      nic1 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "vnet_region1"
        subnet_key              = "servers"
        name                    = "1-bastion_host"
        enable_ip_forwarding    = false
        internal_dns_name_label = "bastion-host-nic1"
        public_ip_address_key   = "bastion_host_pip2"
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
        network_interface_keys = ["nic0","nic1"]

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
}

vnets = {
  vnet_region1 = {
    resource_group_key = "vm_region1"
    vnet = {
      name          = "virtual_machines_vnet"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      bastion = {
        name    = "bastion"
        cidr    = ["10.100.100.0/25"]
        nsg_key = "bastion_ssh"
      }
      servers = {
        name    = "servers"
        cidr    = ["10.100.100.128/25"]
        nsg_key = "windows_server"
      }
    }
  }
}
public_ip_addresses = {
  bastion_host_pip1 = {
    name                    = "bastion_host_pip1"
    resource_group_key      = "vm_region1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }
  bastion_host_pip2 = {
    name                    = "bastion_host_pip2"
    resource_group_key      = "vm_region1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }
}

network_security_group_definition = {

  windows_server = {

    nsg = [
      {
        name                       = "winrm",
        priority                   = "200"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "5985"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "winrms",
        priority                   = "201"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "5986"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "rdp-inbound-3389",
        priority                   = "210"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
      },
    ]
  }

  bastion_ssh = {

    nsg = [
      {
        name                       = "bastion-vnet-out-allow-22",
        priority                   = "103"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
        # source_application_security_group_ids      = 
        # destination_application_security_group_ids = 
      },
    ]
  }

}

keyvaults = {
  ssh_keys = {
    name               = "vmsecrets-new"
    resource_group_key = "vm_region1"
    sku_name           = "standard"

    enabled_for_deployment = true

    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}
