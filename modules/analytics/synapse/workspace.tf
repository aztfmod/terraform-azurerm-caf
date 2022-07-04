# naming convention
resource "azurecaf_name" "ws" {
  name          = var.settings.name
  resource_type = "azurerm_synapse_workspace"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace
# Tested with : AzureRM 2.57.0
resource "azurerm_synapse_workspace" "ws" {
  name                                 = azurecaf_name.ws.result
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = var.storage_data_lake_gen2_filesystem_id
  sql_administrator_login              = var.settings.sql_administrator_login
  sql_administrator_login_password     = try(var.settings.sql_administrator_login_password, random_password.sql_admin.0.result)
  managed_virtual_network_enabled      = try(var.settings.managed_virtual_network_enabled, false)
  sql_identity_control_enabled         = try(var.settings.sql_identity_control_enabled, null)
  managed_resource_group_name          = try(var.settings.managed_resource_group_name, null)
  tags                                 = local.tags

  dynamic "aad_admin" {
    for_each = try(var.settings.aad_admin, {})

    content {
      login     = var.settings.aad_admin.login
      object_id = var.settings.aad_admin.object_id
      tenant_id = var.settings.aad_admin.tenant_id
    }
  }

  dynamic "azure_devops_repo" {
    for_each = try(var.settings.azure_devops_repo, {})

    content {
      account_name    = var.settings.azure_devops_repo.account_name
      branch_name     = var.settings.azure_devops_repo.branch_name
      project_name    = var.settings.azure_devops_repo.project_name
      repository_name = var.settings.azure_devops_repo.branch_name
      root_folder     = var.settings.azure_devops_repo.root_folder
    }
  }

  dynamic "customer_managed_key" {
    for_each = try(var.settings.customer_managed_key_versionless_id, null) == null ? [] : [1]

    content {
      key_versionless_id = try(var.settings.customer_managed_key_versionless_id, null)
    }
  }

  dynamic "github_repo" {
    for_each = try(var.settings.github_repo, {})

    content {
      account_name    = var.settings.github_repo.account_name
      branch_name     = var.settings.github_repo.project_name
      repository_name = var.settings.github_repo.branch_name
      root_folder     = var.settings.github_repo.root_folder
      git_url         = var.settings.github_repo.git_url
    }
  }

}

# Generate sql server random admin password if not provided in the attribute administrator_login_password
resource "random_password" "sql_admin" {
  count = try(var.settings.sql_administrator_login_password, null) == null ? 1 : 0

  length           = 128
  special          = true
  upper            = true
  numeric          = true
  override_special = "$#%"
}

# Store the generated password into keyvault for password rotation support
resource "azurerm_key_vault_secret" "sql_admin_password" {
  count = try(var.settings.sql_administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-synapse-sql-admin-password", azurerm_synapse_workspace.ws.name)
  value        = random_password.sql_admin.0.result
  key_vault_id = var.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "azurerm_key_vault_secret" "sql_admin" {
  count = try(var.settings.sql_administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-synapse-sql-admin-username", azurerm_synapse_workspace.ws.name)
  value        = var.settings.sql_administrator_login
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "synapse_name" {
  count = try(var.settings.sql_administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-synapse-name", azurerm_synapse_workspace.ws.name)
  value        = azurerm_synapse_workspace.ws.name
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "synapse_rg_name" {
  count = try(var.settings.sql_administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-synapse-resource-group-name", azurerm_synapse_workspace.ws.name)
  value        = var.resource_group_name
  key_vault_id = var.keyvault_id
}

# for backwards compatibility to create single firewall rule
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_firewall_rule
# Tested with : AzureRm 2.57.0
resource "azurerm_synapse_firewall_rule" "wrkspc_firewall" {
  count = try(var.settings.workspace_firewall, null) == null ? 0 : 1

  name                 = var.settings.workspace_firewall.name
  synapse_workspace_id = azurerm_synapse_workspace.ws.id
  start_ip_address     = var.settings.workspace_firewall.start_ip
  end_ip_address       = var.settings.workspace_firewall.end_ip
}

# supports adding multiple synapse firewall rules
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_firewall_rule
# Tested with : AzureRm 2.57.0
resource "azurerm_synapse_firewall_rule" "wrkspc_firewalls" {
  for_each = try(var.settings.workspace_firewalls, {})

  # use key as firewall name if name attribute not defined
  name                 = try(each.value.name, each.key)
  synapse_workspace_id = azurerm_synapse_workspace.ws.id
  # start_ip and end_ip must be specified in each individual workspace_firewall_rule
  start_ip_address = each.value.start_ip
  end_ip_address   = each.value.end_ip
}

