# Azure Virtual Machine

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

You can find examples configurations in the github repo - https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/compute/virtual_machine

There is also a standalone example explaining how to create a VM from the CAF registry module - https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/compute/virtual_machine/211-vm-bastion-winrm-agents/registry 

```
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.0.0"

  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  storage_accounts   = var.storage_accounts
  keyvaults          = var.keyvaults
  managed_identities = var.managed_identities
  role_mapping       = var.role_mapping

  diagnostics = {
    # Get the diagnostics settings of services to create
    diagnostic_log_analytics    = var.diagnostic_log_analytics
    diagnostic_storage_accounts = var.diagnostic_storage_accounts
  }

  compute = {
    virtual_machines = var.virtual_machines
  }

  networking = {
    vnets                             = var.vnets
    network_security_group_definition = var.network_security_group_definition
    public_ip_addresses               = var.public_ip_addresses
  }

  security = {
    dynamic_keyvault_secrets = var.dynamic_keyvault_secrets
  }
}

output diagnostics {
  value = module.caf.diagnostics
}
```
