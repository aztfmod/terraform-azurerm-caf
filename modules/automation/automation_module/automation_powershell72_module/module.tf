resource "azurerm_automation_powershell72_module" "automation_powershell72_module" {
  name                  = var.settings.name
  automation_account_id = var.automation_account_id
  tags                  = local.tags

  module_link {
    uri = var.settings.module_link.uri

    dynamic "hash" {
      for_each = try(var.settings.module_link.hash, null) == null ? [] : [1]

      content {
        algorithm = hash.algorithm
        value     = hash.value
      }
    }
  }
}
