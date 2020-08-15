
resource "azurecaf_naming_convention" "stg" {
  name          = var.storage_account.name
  prefix        = var.global_settings.prefix
  resource_type = "azurerm_storage_account"
  convention    = var.global_settings.convention
}

resource "azurerm_storage_account" "stg" {
  name                      = azurecaf_naming_convention.stg.result
  resource_group_name       = var.resource_groups[var.storage_account.resource_group_key].name
  location                  = lookup(var.storage_account, "location", var.resource_groups[var.storage_account.resource_group_key].location)
  account_tier              = lookup(var.storage_account, "account_tier", "Standard")
  account_replication_type  = lookup(var.storage_account, "account_replication_type", "LRS")
  account_kind              = lookup(var.storage_account, "account_kind", "StorageV2")
  access_tier               = lookup(var.storage_account, "access_tier", "Hot")
  enable_https_traffic_only = true
  min_tls_version           = lookup(var.storage_account, "min_tls_version", "TLS1_2")
  allow_blob_public_access  = lookup(var.storage_account, "allow_blob_public_access", false)
  is_hns_enabled            = lookup(var.storage_account, "is_hns_enabled", false)
  tags                      = lookup(var.storage_account, "tags", {})


  dynamic "custom_domain" {
    for_each = lookup(var.storage_account, "custom_domain", false) == false ? [] : [1]

    content {
      name          = var.storage_account.custom_domain.name
      use_subdomain = var.storage_account.custom_domain.use_subdomain
    }
  }

  dynamic "identity" {
    for_each = lookup(var.storage_account, "enable_system_msi", false) == false ? [] : [1]

    content {
      type = "SystemAssigned"
    }
  }

  dynamic "blob_properties" {
    for_each = lookup(var.storage_account, "blob_properties", false) == false ? [] : [1]

    content {
      dynamic "cors_rule" {
        for_each = lookup(var.storage_account.blob_properties, "cors_rule", false) == false ? [] : [1]

        content {
          allowed_headers    = var.storage_account.blob_properties.cors_rule.allowed_headers
          allowed_methods    = var.storage_account.blob_properties.cors_rule.allowed_methods
          allowed_origins    = var.storage_account.blob_properties.cors_rule.allowed_origins
          exposed_headers    = var.storage_account.blob_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.storage_account.blob_properties.cors_rule.max_age_in_seconds
        }
      }

      dynamic "delete_retention_policy" {
        for_each = lookup(var.storage_account.blob_properties, "delete_retention_policy", false) == false ? [] : [1]

        content {
          days = lookup(var.storage_account.blob_properties.delete_retention_policy, "days", 7)
        }
      }
    }

  }

  dynamic "queue_properties" {
    for_each = lookup(var.storage_account, "queue_properties", false) == false ? [] : [1]

    content {
      dynamic "cors_rule" {
        for_each = lookup(var.storage_account.queue_properties, "cors_rule", false) == false ? [] : [1]

        content {
          allowed_headers    = var.storage_account.queue_properties.cors_rule.allowed_headers
          allowed_methods    = var.storage_account.queue_properties.cors_rule.allowed_methods
          allowed_origins    = var.storage_account.queue_properties.cors_rule.allowed_origins
          exposed_headers    = var.storage_account.queue_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.storage_account.queue_properties.cors_rule.max_age_in_seconds
        }
      }

      dynamic "logging" {
        for_each = lookup(var.storage_account.queue_properties, "logging", false) == false ? [] : [1]

        content {
          delete                = var.storage_account.queue_properties.logging.delete
          read                  = var.storage_account.queue_properties.logging.read
          write                 = var.storage_account.queue_properties.logging.write
          version               = var.storage_account.queue_properties.logging.version
          retention_policy_days = lookup(var.storage_account.queue_properties.logging, "retention_policy_days", 7)
        }
      }

      dynamic "minute_metrics" {
        for_each = lookup(var.storage_account.queue_properties, "minute_metrics", false) == false ? [] : [1]

        content {
          enabled               = var.storage_account.queue_properties.minute_metrics.enabled
          version               = var.storage_account.queue_properties.minute_metrics.version
          include_apis          = lookup(var.storage_account.queue_properties.minute_metrics, "include_apis", null)
          retention_policy_days = lookup(var.storage_account.queue_properties.minute_metrics, "retention_policy_days", 7)
        }
      }

      dynamic "hour_metrics" {
        for_each = lookup(var.storage_account.queue_properties, "hour_metrics", false) == false ? [] : [1]

        content {
          enabled               = var.storage_account.queue_properties.hour_metrics.enabled
          version               = var.storage_account.queue_properties.hour_metrics.version
          include_apis          = lookup(var.storage_account.queue_properties.hour_metrics, "include_apis", null)
          retention_policy_days = lookup(var.storage_account.queue_properties.hour_metrics, "retention_policy_days", 7)
        }
      }
    }
  }

  dynamic "static_website" {
    for_each = lookup(var.storage_account, "static_website", false) == false ? [] : [1]

    content {
      index_document     = var.storage_account.static_website.index_document
      error_404_document = var.storage_account.static_website.error_404_document
    }
  }

  dynamic "network_rules" {
    for_each = lookup(var.storage_account, "network_rules", false) == false ? [] : [1]

    content {
      default_action             = lookup(var.storage_account.network_rules, "default_action", "Deny")
      bypass                     = lookup(var.storage_account.network_rules, "bypass", "None")
      ip_rules                   = lookup(var.storage_account.network_rules, "ip_rules", null)
      virtual_network_subnet_ids = lookup(var.storage_account.network_rules, "default_action", null)
    }
  }

}

resource "azurerm_storage_container" "stg" {
  for_each = lookup(var.storage_account, "containers", {})

  name                  = each.value.name
  storage_account_name  = azurerm_storage_account.stg.name
  container_access_type = lookup(each.value, "container_access_type", null)
  metadata              = lookup(each.value, "metadata", null)
}


# locals {
#   storage_account_virtual_network_subnet_ids = flatten(
#     [
#       for subnet_key in var.storage_accounts.network_interface_keys : [
#         azurerm_network_interface.nic[nic_key].id
#       ]
#     ]
#   )
# }