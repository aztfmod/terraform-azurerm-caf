global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope"
  }
}

resource_groups = {
  rg1 = {
    name   = "rsg_umc"
    region = "region1"
  }
}

keyvaults = {
  example_vm_rg1 = {
    name               = "vmsecrets"
    resource_group_key = "rg1"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

vnets = {
  vnet_region1 = {
    resource_group_key = "rg1"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      example = {
        name = "examples"
        cidr = ["10.100.100.0/29"]
      }
    }

  }
}

public_ip_addresses = {
  example_vm_pip1_rg1 = {
    name                    = "example_vm_pip1"
    resource_group_key      = "rg1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }
}

virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  example_vm1 = {
    resource_group_key = "rg1"
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
        subnet_key              = "example"
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
        public_ip_address_key   = "example_vm_pip1_rg1"
      }
    }

    virtual_machine_settings = {
      windows = {
        name           = "example_vm1"
        size           = "Standard_F2"
        admin_username = "adminuser"


        # Spot VM to save money
        priority        = "Spot"
        eviction_policy = "Deallocate"

        patch_mode                                             = "AutomaticByPlatform"
        bypass_platform_safety_checks_on_user_schedule_enabled = true
        # When you want to load the file from the folder in the custom_data always use the relative path from the caf_solution in landing zones
        custom_data = "../../examples/compute/virtual_machine/101-single-windows-vm/scripts/custom.ps1"
        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "example_vm1-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2019-Datacenter"
          version   = "latest"
        }

      }
    }
  }
}

maintenance_configuration = {
  mc_re1 = {
    name                     = "example-mc"
    region                   = "region1"
    resource_group_key       = "rg1"
    scope                    = "InGuestPatch"
    in_guest_user_patch_mode = "User"
    window = {
      start_date_time = "2023-06-08 15:04"
      duration        = "03:55"
      time_zone       = "Romance Standard Time"
      recur_every     = "2Day"
    }

    install_patches = {
      windows = {
        classifications_to_include = ["Critical", "Security"]
        # kb_numbers_to_exclude      = ["KB123456", "KB789012"]
        # kb_numbers_to_include      = ["KB345678", "KB901234"]
      }
      reboot = "IfRequired"
    }
    # tags               = {} # optional
  }
}

maintenance_assignment_virtual_machine = {
  example = {
    region                        = "region1"
    maintenance_configuration_key = "mc_re1"
    virtual_machine = {
      key = "example_vm1"
    }
  }
}
