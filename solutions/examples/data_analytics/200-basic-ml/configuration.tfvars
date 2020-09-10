# Requires:
# - caf_launchpad scenario 200+
# - caf_foundations
# - caf_neworking with 200-multi-region-hub
# - 200-basic-ml networking_spoke

tfstates = {
  caf_foundations = {
    tfstate = "caf_foundations.tfstate"
  }
  networking = {
    tfstate = "200-basic-ml-networking_spoke.tfstate"
  }
}


resource_groups = {
  dap_jumpbox_re1 = {
    name = "dap-jumpbox-re1"
  }
}

# Virtual machines
virtual_machines = {

  # Deploy a jumpbox in the vnet hub to access resource from the bastion service
  jumpbox = {
    resource_group_key = "dap_jumpbox_re1"
    # boot_diagnostics_storage_account_key = "bootdiag_re1"
    provision_vm_agent = true

    os_type = "windows"

    # when not set the password is auto-generated and stored into the keyvault
    keyvault_key = "secrets"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        networking = {
          remote_tfstate = {
            tfstate_key = "dap_networking_spoke"
            output_key  = "vnets"
            lz_key      = "dap_networking_spoke"
            vnet_key    = "spoke_dap_re1"
            subnet_key  = "jumpbox"
          }
        }
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "jumpbox"

        # you can setup up to 5 profiles
        diagnostic_profiles = {
          operations = {
            definition_key   = "nic"
            destination_type = "log_analytics"
            destination_key  = "central_logs"
          }
        }

      }
    }

    virtual_machine_settings = {
      windows = {
        name                            = "jumpbox-dsvm"
        size                            = "Standard_D4s_v3"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "jumpbox-os"
          caching              = "ReadWrite"
          create_option        = "FromImage"
          storage_account_type = "Standard_LRS"
          managed_disk_type    = "StandardSSD_LRS"
          disk_size_gb         = "128"
        }

        source_image_reference = {
          publisher = "microsoft-dsvm"
          offer     = "dsvm-windows"
          sku       = "server-2019"
          version   = "latest"
        }

        identity = {
          type = "UserAssigned"
          # remote_state = {
          # }
          managed_identity_keys = [
            "jumpbox",
          ]
        }

      }
    }

  }
}

storage_accounts = {
  level0 = {
    name                     = "level0"
    resource_group_key       = "tfstate"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
    tags = {
      ## Those tags must never be changed after being set as they are used by the rover to locate the launchpad and the tfstates.
      # Only adjust the environment value at creation time
      tfstate     = "level0"
      environment = "sandpit"
      launchpad   = "launchpad"
      ##
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }
}

keyvaults = {
  secrets = {
    name                = "secrets"
    resource_group_key  = "dap_jumpbox_re1"
    convention          = "cafrandom"
    sku_name            = "premium"
    soft_delete_enabled = true

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "default_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}

keyvault_access_policies = {
  secrets = {
    logged_in_user = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    logged_in_aad_app = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    dap_admins = {
      azuread_group_key  = "dap_admins"
      secret_permissions = ["Get", "List"]
    }
  }
}


#
# IAM
#

managed_identities = {
  jumpbox = {
    name               = "dap-jumpbox"
    resource_group_key = "dap_jumpbox_re1"
  }
}

azuread_groups = {
  dap_admins = {
    name        = "dap-admins"
    description = "Provide access to the Data Analytics Platform services and the jumpbox Keyvault secret."
    members = {
      user_principal_names = [
      ]
      group_names = []
      object_ids  = []
      group_keys  = []

      service_principal_keys = [
      ]
    }
    prevent_duplicate_name = false
  }
}
