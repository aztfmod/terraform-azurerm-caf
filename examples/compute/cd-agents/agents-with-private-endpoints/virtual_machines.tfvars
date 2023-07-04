provider_azurerm_features_virtual_machine = {
  # To allow in-vm sheduled event to be sent and de-register properly the agents
  graceful_shutdown = true
}

virtual_machines = {
  azdo_level0 = {
    resource_group_key = "agents"
    provision_vm_agent = true
    os_type            = "linux"
    keyvault_key       = "agents"

    networking_interfaces = {
      nic0 = {
        subnet_key              = "agents"
        name                    = "nic0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "agent-azdo-level0"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "azdo"
        size                            = "Standard_F4s_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        #  custom_data = "/tf/caf/platform/configuration/level1/gitops/az_devops_agents_vm/scripts/cloud-init-install-rover-tools.config"
        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "canonical"
          offer     = "0001-com-ubuntu-server-jammy"
          sku       = "22_04-lts-gen2"
          version   = "latest"
        }

        identity = {
          type                  = "SystemAssigned, UserAssigned"
          managed_identity_keys = ["gitops"]
          # remote = {
          #   launchpad = {
          #     managed_identity_keys = [
          #       "gitops",
          #     ]
          #   }
          # }
        }
      }
    }

    virtual_machine_extensions = {
      devops_selfhosted_agent = {
        agent_init_script = "rover_agents.sh"
        storage_account_blobs = [
          "rover_agents"
        ]

        managed_identity = {
          key = "gitops"
        }

        rover_version = "aztfmod/rover-agent:1.4.6-2306.2308-azdo"
        url           = "https://dev.azure.com/terraformdev/"
        # pats = {
        #   # secret_name  = "azdo-pat-agent"
        #   # keyvault_key = "secrets"
        #   value = "your_PAT_in_cleartext_only_for_testing"
        # }


        pats_from_env_variable = {
          variable_name  = "AZDO_TOKEN"
          fails_if_empty = true
        }

        agent_pool_name   = "contoso-level0"
        auto_provision    = true
        num_agents        = 10
        agent_name_prefix = "agent-azdo-level0"

      }
      generic_extensions = {
        AADSSHLogin = {
          name                       = "AADSSHLogin"
          publisher                  = "Microsoft.Azure.ActiveDirectory"
          type                       = "AADSSHLoginForLinux"
          type_handler_version       = "1.0"
          auto_upgrade_minor_version = true
        }
      }
    }
  }

  tfcloud = {
    resource_group_key = "agents"
    provision_vm_agent = true
    os_type            = "linux"
    keyvault_key       = "agents"

    networking_interfaces = {
      nic0 = {
        subnet_key              = "agents"
        name                    = "nic0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "agent-tfcloud-level0"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "tfcloud"
        size                            = "Standard_F4s_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "RedHat"
          offer     = "RHEL"
          sku       = "87-gen2"
          version   = "latest"
        }

        identity = {
          type                  = "SystemAssigned, UserAssigned"
          managed_identity_keys = ["gitops"]
          # remote = {
          #   launchpad = {
          #     managed_identity_keys = [
          #       "gitops",
          #     ]
          #   }
          # }
        }
      }
    }

    virtual_machine_extensions = {
      tfcloud_selfhosted_agent = {
        agent_init_script = "tfcloud_selfhosted_agent.sh"
        storage_account_blobs = [
          "tfcloud_selfhosted_agent"
        ]

        managed_identity = {
          key = "gitops"
        }

        rover_version = "aztfmod/rover-agent:1.4.6-2306.2308-tfc"
        url           = "https://app.terraform.io"
        # pats = {
        #   # secret_name  = "azdo-pat-agent"
        #   # keyvault_key = "secrets"
        #   value = "your_PAT_in_cleartext_only_for_testing"
        # }

        pats_from_env_variable = {
          variable_name  = "TFCLOUD_TOKEN"
          fails_if_empty = true
        }

        num_agents        = 5
        agent_name_prefix = "agent-tfe"

      }
      generic_extensions = {
        AADSSHLogin = {
          name                       = "AADSSHLogin"
          publisher                  = "Microsoft.Azure.ActiveDirectory"
          type                       = "AADSSHLoginForLinux"
          type_handler_version       = "1.0"
          auto_upgrade_minor_version = true
        }
      }
    }
  }

}
