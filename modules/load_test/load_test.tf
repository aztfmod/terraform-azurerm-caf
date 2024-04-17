# Terraform azurerm resource: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/load_test

data "azurecaf_name" "this" {
  name          = var.settings.name
  resource_type = "azurerm_load_test"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_load_test" "this" {
  name                = data.azurecaf_name.this.result
  resource_group_name = local.resource_group_name
  location            = local.location
  description         = try(var.settings.description, null)

  dynamic "identity" {
    for_each = lookup(var.settings, "identity", {}) == {} ? [] : [1]
    content {
      type         = var.settings.identity.type
      identity_ids = local.managed_identities
    }
  }

  tags = merge(local.tags, lookup(var.settings, "tags", {}))
}
