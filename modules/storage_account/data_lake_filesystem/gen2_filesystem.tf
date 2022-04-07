# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_filesystem

resource "azurerm_storage_data_lake_gen2_filesystem" "gen2" {
  name               = var.settings.name
  storage_account_id = var.storage_account_id
  properties = {
    for key, value in try(var.settings.properties) : key => base64encode(value)
  }
  dynamic "ace" {
    for_each = try(var.settings.ace, {})
    content {
      scope       = ace.value.scope
      permissions = ace.value.perm
      type        = ace.value.type
      id          = try(var.azuread_groups[var.client_config.landingzone_key][ace.value.ad_group_key].id, ace.value.id)
    }
  }
}