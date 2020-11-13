locals {
  # Need to update the storage tags if the environment tag is updated with the rover command line
  tags = lookup(var.storage_account, "tags", null) == null ? null : lookup(var.storage_account.tags, "environment", null) == null ? var.storage_account.tags : merge(lookup(var.storage_account, "tags", {}), { "environment" : var.global_settings.environment })
}

# naming convention
resource "azurecaf_name" "stg" {
  name          = var.storage_account.name
  resource_type = "azurerm_storage_account"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_storage_account" "stg" {
  name                      = azurecaf_name.stg.result
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = lookup(var.storage_account, "account_tier", "Standard")
  account_replication_type  = lookup(var.storage_account, "account_replication_type", "LRS")
  account_kind              = lookup(var.storage_account, "account_kind", "StorageV2")
  access_tier               = lookup(var.storage_account, "access_tier", "Hot")
  enable_https_traffic_only = true
  min_tls_version           = lookup(var.storage_account, "min_tls_version", "TLS1_2")
  allow_blob_public_access  = lookup(var.storage_account, "allow_blob_public_access", false)
  is_hns_enabled            = lookup(var.storage_account, "is_hns_enabled", false)
  tags                      = merge(local.tags, var.base_tags)


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
    for_each = lookup(var.storage_account, "network", {})

    content {
      bypass         = network_rules.value.bypass
      default_action = try(network_rules.value.default_action, "Deny")
      ip_rules       = try(network_rules.value.ip_rules, null)
      virtual_network_subnet_ids = [
        for subnet_key in network_rules.value.subnet_keys : var.vnets[network_rules.key].subnets[subnet_key].id
      ]
    }
  }

}

module container {
  source   = "./container"
  for_each = try(var.storage_account.containers, {})

  storage_account_name = azurerm_storage_account.stg.name
  settings             = each.value
}

module data_lake_filesystem {
  source   = "./data_lake_filesystem"
  for_each = try(var.storage_account.data_lake_filesystems, {})

  storage_account_id = azurerm_storage_account.stg.id
  settings           = each.value
}
