// waiting caf naming for this resource
#resource "azurecaf_name" "ece" {
#  name          = var.settings.name
#  resource_type = "azurerm_elastic_cloud_elasticsearch"
#  prefixes      = var.global_settings.prefixes
#  random_length = var.global_settings.random_length
#  clean_input   = true
#  passthrough   = var.global_settings.passthrough
#  use_slug      = var.global_settings.use_slug
#}


resource "azurerm_resource_provider_registration" "elastic" {
  name = "Microsoft.Elastic"
}

resource "azurerm_elastic_cloud_elasticsearch" "ece" {
  #name                       = azurecaf_name.ece.result
  name                        = var.settings.name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  sku_name                    = var.settings.sku_name
  elastic_cloud_email_address = var.settings.elastic_cloud_email_address
  monitoring_enabled          = try(var.settings.monitoring_enabled, true)
  tags                        = merge(local.tags, try(var.settings.tags, null))
  dynamic "logs" {
    for_each = try(var.settings.logs, null) == null ? [] : [1]
    content {
      send_activity_logs     = try(var.settings.logs.send_activity_logs, false)
      send_azuread_logs      = try(var.settings.logs.send_azuread_logs, false)
      send_subscription_logs = try(var.settings.logs.send_subscription_logs, false)
      
      dynamic "filtering_tag" {
        for_each = {
          for key, value in try(var.settings.logs.filtering_tags, {}) : key => value
        }
        content {         
          action = filtering_tag.value.action
          name   = filtering_tag.value.name
          value  = filtering_tag.value.value
        }
      }
    }
  }
  depends_on = [ azurerm_resource_provider_registration.elastic ]
}
