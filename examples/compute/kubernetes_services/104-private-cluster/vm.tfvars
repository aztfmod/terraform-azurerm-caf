virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  bastion_host = {
    resource_group_key = "aks_jumpbox_re1"
    provision_vm_agent = true

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "jumpbox"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # AKS rely on a remote network and need the details of the tfstate to connect (tfstate_key), assuming RBAC authorization.

        vnet_key                = "spoke_aks_re1"
        subnet_key              = "jumpbox"
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"

        # you can setup up to 5 profiles
        # diagnostic_profiles = {
        #   operations = {
        #     definition_key   = "nic"
        #     destination_type = "log_analytics"
        #     destination_key  = "central_logs"
        #   }
        # }

      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "jumpbox"
        size                            = "Standard_DS1_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        custom_data                     = "scripts/cloud-init/install-rover-tools.config"

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
          sku       = "18.04-LTS"
          version   = "latest"
        }

        identity = {
          type                  = "UserAssigned"
          managed_identity_keys = ["jumpbox"]
        }

      }
    }

  }
}