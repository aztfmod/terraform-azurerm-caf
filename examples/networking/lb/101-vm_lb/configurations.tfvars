
/* The  Following config creates a Linux VM with 2 Network Interface Cards and attach them behind a LB */

global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  lb = {
    name = "example-lb"
  }
}

vnets = {
  vnet_test = {
    resource_group_key = "lb"
    vnet = {
      name          = "vnet-test"
      address_space = ["10.1.0.0/16"]
    }
    specialsubnets = {}
    subnets = {
      subnet1 = {
        name = "test-sn"
        cidr = ["10.1.1.0/24"]
      }
      subnet2 = {
        name = "test-sn2"
        cidr = ["10.1.2.0/24"]
      }
    }
  }
}

public_ip_addresses = {
  pip = {
    name                    = "lb_pip1"
    resource_group_key      = "lb"
    sku                     = "Basic" #SKU must match with the SKU of the LB
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

virtual_machines = {

  vm1 = {
    resource_group_key = "lb"
    os_type            = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "example_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "vnet_test"
        subnet_key              = "subnet1"
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
        public_ip_address_key   = "pip"
      }
      nic1 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "vnet_test"
        subnet_key              = "subnet2"
        name                    = "1"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic1"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "example_vm1"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0", "nic1"]

        os_disk = {
          name                 = "example_vm1-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
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
lb = {
  lb1 = {
    name   = "lb-test"
    region = "region1"
    resource_group = {
      key = "lb"
    }
    frontend_ip_configuration = {
      name = "config1"
      subnet = {
        vnet_key = "vnet_test"
        key      = "subnet1"
      }
      private_ip_address_allocation = "Dynamic"
    }
    sku = "basic" #SKU must match with the SKU of the PIP
  }
}
lb_backend_address_pool = {
  lbap1 = {
    loadbalancer = {
      key = "lb1"
    }
    name = "BackEndAddressPool"
  }
}
#multiple VMs and NICs can be attached to the Load Balancer. Specify the respective VMs and NICs in the following syntac
network_interface_backend_address_pool_association = {
  bap0 = {
    backend_address_pool = {
      key = "lbap1"
      #id = ""
    }
    # ip_configuration_name = "0"
    network_interface = {
      vm_key  = "vm1"
      nic_key = "nic0"
      #id = ""
    }
  }
}
keyvaults = {
  example_vm_rg1 = {
    name               = "vmsecrets"
    resource_group_key = "lb"
    sku_name           = "standard"
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  example_vm_rg1 = {
    logged_in_user = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }
}