# Resorce type doesn't "azurerm_logic_app_workflow" doesn't exist in azurecaf!!
# resource "azurecaf_name" "df" {
#   name          = var.name
#   resource_type = "azurerm_data_factory"
#   prefixes      = [var.global_settings.prefix]
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }

resource "azurerm_data_factory" "df" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "github_configuration" {
    for_each = lookup(var.settings, "github_configuration", {}) == {} ? [] : [1]

    content {
      account_name    = var.settings.github_configuration.account_name
      branch_name     = var.settings.github_configuration.branch_name
      git_url         = var.settings.github_configuration.git_url
      repository_name = var.settings.github_configuration.repository_name
      root_folder     = var.settings.github_configuration.root_folder
    }
  }

  dynamic "identity" {
    for_each = lookup(var.settings, "identity", {}) == {} ? [] : [1]

    content {
      type = var.settings.identity.type
    }
  }

  dynamic "vsts_configuration" {
    for_each = lookup(var.settings, "vsts_configuration", {}) == {} ? [] : [1]

    content {
      account_name    = var.settings.vsts_configuration.account_name
      branch_name     = var.settings.vsts_configuration.branch_name
      project_name    = var.settings.vsts_configuration.project_name
      repository_name = var.settings.vsts_configuration.repository_name
      root_folder     = var.settings.vsts_configuration.root_folder
      tenant_id       = var.settings.vsts_configuration.tenant_id
    }
  }

  tags = merge(var.tags, var.base_tags)
}