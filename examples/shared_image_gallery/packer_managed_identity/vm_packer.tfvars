vnets = {
  packer_vnet = {
    resource_group_key = "packer"
    vnet = {
      name          = "packer_vnet"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      servers = {
        name    = "packer_subnet"
        cidr    = ["10.100.100.128/25"]
        nsg_key = "packer"
      }
    }

  }
}

network_security_group_definition = {
  packer = {
    nsg = [
      {
        name                       = "ssh",
        priority                   = "200"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "http",
        priority                   = "201"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "https",
        priority                   = "210"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
    ]
  }

}

public_ip_addresses = {
  packer_vm_pip = {
    name                    = "packer_vm_pip"
    resource_group_key      = "packer"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }
}

# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  packer_vm = {
    resource_group_key                   = "packer"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "packer"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "packer_vnet"
        subnet_key              = "packer_vnet"
        name                    = "0-packer_host"
        enable_ip_forwarding    = false
        internal_dns_name_label = "packer-host-nic0"
        public_ip_address_key   = "packer_vm_pip"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "packer_vm"
        size                            = "Standard_A2_V2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        custom_data                     = "./scripts/cloud-init/install-ansible-packer.config"
        zone                            = "1"
        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]
        os_disk = {
          name                 = "packer_host-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }
        source_image_reference = {
          publisher = "canonical"
          offer     = "0001-com-ubuntu-server-focal"
          sku       = "20_04-lts"
          version   = "latest"
        }
        identity = {
          type                  = "UserAssigned"
          managed_identity_keys = ["packer"]
        }
      }
    }

  }

}