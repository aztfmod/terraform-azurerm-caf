
resource "azurecaf_name" "syws" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_synapse_workspace"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_synapse_workspace" "syws" {
  name                                 = azurecaf_name.syws.result
  resource_group_name                  = can(var.settings.resource_group.name) ? var.settings.resource_group.name : var.remote_objects.resource_group[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = can(var.settings.storage_data_lake_gen2_filesystem.id) ? var.settings.storage_data_lake_gen2_filesystem.id : var.remote_objects.storage_data_lake_gen2_filesystem[try(var.settings.storage_data_lake_gen2_filesystem.lz_key, var.client_config.landingzone_key)][var.settings.storage_data_lake_gen2_filesystem.key].id
  sql_administrator_login              = var.settings.sql_administrator_login
  sql_administrator_login_password     = var.settings.sql_administrator_login_password
  linking_allowed_for_aad_tenant_ids   = try(var.settings.linking_allowed_for_aad_tenant_ids, null)
  compute_subnet_id                    = try(var.settings.compute_subnet_id, null)
  data_exfiltration_protection_enabled = try(var.settings.data_exfiltration_protection_enabled, null)
  managed_virtual_network_enabled      = try(var.settings.managed_virtual_network_enabled, null)
  public_network_access_enabled        = try(var.settings.public_network_access_enabled, null)
  purview_id                           = try(var.settings.purview_id, null)
  sql_identity_control_enabled         = try(var.settings.sql_identity_control_enabled, null)
  managed_resource_group_name          = try(var.settings.managed_resource_group_name, null)
  dynamic "aad_admin" {
    for_each = try(var.settings.aad_admin, null) != null ? [var.settings.aad_admin] : []
    content {
      login     = try(aad_admin.value.login, null)
      object_id = try(aad_admin.value.object_id, null)
      tenant_id = try(aad_admin.value.tenant_id, null)
    }
  }
  dynamic "azure_devops_repo" {
    for_each = try(var.settings.azure_devops_repo, null) != null ? [var.settings.azure_devops_repo] : []
    content {
      account_name    = try(azure_devops_repo.value.account_name, null)
      branch_name     = try(azure_devops_repo.value.branch_name, null)
      last_commit_id  = try(azure_devops_repo.value.last_commit_id, null)
      project_name    = try(azure_devops_repo.value.project_name, null)
      repository_name = try(azure_devops_repo.value.repository_name, null)
      root_folder     = try(azure_devops_repo.value.root_folder, null)
      tenant_id       = try(azure_devops_repo.value.tenant_id, null)
    }
  }
  dynamic "github_repo" {
    for_each = try(var.settings.github_repo, null) != null ? [var.settings.github_repo] : []
    content {
      account_name    = try(github_repo.value.account_name, null)
      branch_name     = try(github_repo.value.branch_name, null)
      last_commit_id  = try(github_repo.value.last_commit_id, null)
      repository_name = try(github_repo.value.repository_name, null)
      root_folder     = try(github_repo.value.root_folder, null)
      git_url         = try(github_repo.value.git_url, null)
    }
  }
  dynamic "customer_managed_key" {
    for_each = try(var.settings.customer_managed_key, null) != null ? [var.settings.customer_managed_key] : []
    content {
      key_versionless_id = try(customer_managed_key.value.key_versionless_id, null)
      key_name           = try(customer_managed_key.value.key_name, null)
    }
  }
  dynamic "sql_aad_admin" {
    for_each = try(var.settings.sql_aad_admin, null) != null ? [var.settings.sql_aad_admin] : []
    content {
      login     = try(sql_aad_admin.value.login, null)
      object_id = try(sql_aad_admin.value.object_id, null)
      tenant_id = try(sql_aad_admin.value.tenant_id, null)
    }
  }
  tags = local.tags
}