resource "azurerm_log_analytics_solution" "solution" {
  for_each = lookup(var.log_analytics, "solutions_maps", {})

  solution_name         = each.key
  location              = var.global_settings.regions[var.log_analytics.region]
  resource_group_name   = var.resource_groups[var.log_analytics.resource_group_key].name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher      = lookup(each.value, "publisher")
    product        = lookup(each.value, "product")
    promotion_code = lookup(each.value, "promotion_code", null)
  }
}