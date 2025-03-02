global_settings = {
  default_region                        = "region1"
  regions = {
    region1                             = "australiaeast"
  }
}

resource_groups = {
  rg_lb_001 = {
    name                                = "loadbalancer-example"
  }
}

vnets = {
  vnet_lb_001 = {
    resource_group_key                  = "rg_lb_001"
    vnet = {
      name                              = "loadbalancer-example"
      address_space                     = ["192.168.1.0/24"]
    }
    subnets = {
      snet_lb_001 = {
        name                            = "loadbalancer-example"
        cidr                            = ["192.168.1.0/24"]
      }
    }
  }
}

lb = {
  lb_lb_001 = {
    name                                = "loadbalancer-example"
    resource_group_key                  = "rg_lb_001"
    frontend_ip_configuration = {
      fipc_001 = {
        name                            = "loadbalancer-example-001"
        subnet = {
          vnet_key                      = "vnet_lb_001"
          key                           = "snet_lb_001"
        }
        private_ip_address_allocation = "Static"
        private_ip_address              = "192.168.1.10"
      }
      fipc_002 = {
        name                            = "loadbalancer-example-002"
        subnet = {
          vnet_key                      = "vnet_lb_001"
          key                           = "snet_lb_001"
        }
        private_ip_address_allocation   = "Static"
        private_ip_address              = "192.168.1.15"
      }
    }
    sku                                 = "Standard"
  }
}

lb_backend_address_pool = {
  lbap_lb_001 = {
    loadbalancer = {
      key                               = "lb_lb_001"
    }
    name                                = "loadbalancer-example"
  }
}

network_interface_backend_address_pool_association = {
  bap_lb_001 = {
    backend_address_pool = {
      key                               = "lbap_lb_001"
    }
    network_interface = {
      vm_key                            = "vm_lb_001"
      nic_key                           = "nic_lb_001"
      # id                              = ""
    }
  }
  bap_lb_002 = {
    backend_address_pool = {
      key                               = "lbap_lb_001"
    }
    network_interface = {
      vm_key                            = "vm_lb_002"
      nic_key                           = "nic_lb_002"
      # id                              = ""
    }
  }
}

lb_probe = {
  tcp_80_probe = {
    resource_group_key                  = "rg_lb_001"
    loadbalancer = {
      key                               = "lb_lb_001"
    }
    name                                = "tcp-80-probe"
    port                                = 80
    protocol                            = "Tcp"
    interval_in_seconds                 = 5
    number_of_probes                    = 3
  }

  tcp_443_probe = {
    resource_group_key                  = "rg_lb_001"
    loadbalancer = {
      key                               = "lb_lb_001"
    }
    name                                = "tcp-443-probe"
    port                                = 443
    protocol                            = "Tcp"
    interval_in_seconds                 = 5
    number_of_probes                    = 3
  }
}

lb_rule = {
  lbr_lb_001 = {
    resource_group = {
      key                               = "rg_lb_001"
    }
    loadbalancer = {
      key                               = "lb_lb_001"
    }
    backend_address_pool = {
      lbap_lb_001 = {
        key                             = "lbap_lb_001"
      }
    }
    probe = {
      key                               = "tcp_80_probe"
    }
    name                                = "lbrule-01"
    frontend_port                       = "80"
    backend_port                        = "80"
    protocol                            = "Tcp"
    disable_outbound_snat               = true
    enable_floating_ip                  = true
    idle_timeout_in_minutes             = 30
    frontend_ip_configuration_name      = "loadbalancer-example-001"
  }
  lbr_lb_002 = {
    resource_group = {
      key                               = "rg_lb_001"
    }
    loadbalancer = {
      key                               = "lb_lb_001"
    }
    backend_address_pool = {
      lbap_lb_001 = {
        key                             = "lbap_lb_001"
      }
    }
    probe = {
      key                               = "tcp_443_probe"
    }
    name                                = "lbrule-02"
    frontend_port                       = "443"
    backend_port                        = "443"
    protocol                            = "Tcp"
    disable_outbound_snat               = true
    enable_floating_ip                  = true
    idle_timeout_in_minutes             = 30
    frontend_ip_configuration_name      = "loadbalancer-example-002"
  }
}

keyvaults = {
  kv_lb_001 = {
    name                                = "loadbalancer-example"
    resource_group_key                  = "rg_lb_001"
    sku_name                            = "standard"
    creation_policies = {
      logged_in_user = {
        secret_permissions              = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
        key_permissions                 = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge"]
      }
    }
  }
}

virtual_machines = {
  vm_lb_001 = {
    resource_group_key                  = "rg_lb_001"
    os_type                             = "linux"
    keyvault_key                        = "kv_lb_001"

    networking_interfaces = {
      nic_lb_001 = {
        vnet_key                        = "vnet_lb_001"
        subnet_key                      = "snet_lb_001"
        name                            = "loadbalancer-example-001"
        enable_ip_forwarding            = false
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "loadbalancer-example-001"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        network_interface_keys          = ["nic_lb_001"]

        os_disk = {
          name                          = "loadbalancer-example-001"
          caching                       = "ReadWrite"
          storage_account_type          = "Standard_LRS"
        }

        source_image_reference = {
          publisher                     = "Canonical"
          offer                         = "UbuntuServer"
          sku                           = "18.04-LTS"
          version                       = "latest"
        }
      }
    }
  }
  vm_lb_002 = {
    resource_group_key                  = "rg_lb_001"
    os_type                             = "linux"
    keyvault_key                        = "kv_lb_001"

    networking_interfaces = {
      nic_lb_002 = {
        vnet_key                        = "vnet_lb_001"
        subnet_key                      = "snet_lb_001"
        name                            = "loadbalancer-example-002"
        enable_ip_forwarding            = false
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "loadbalancer-example-002"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        network_interface_keys          = ["nic_lb_002"]

        os_disk = {
          name                          = "loadbalancer-example-002"
          caching                       = "ReadWrite"
          storage_account_type          = "Standard_LRS"
        }

        source_image_reference = {
          publisher                     = "Canonical"
          offer                         = "UbuntuServer"
          sku                           = "18.04-LTS"
          version                       = "latest"
        }
      }
    }
  }
}
