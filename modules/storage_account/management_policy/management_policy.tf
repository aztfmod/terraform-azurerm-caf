resource "azurerm_storage_management_policy" "mgmt_policy" {
  storage_account_id = var.storage_account_id

  dynamic "rule" {
    for_each = var.settings.rules

    content {
      name    = rule.value.name
      enabled = rule.value.enabled

      dynamic "filters" {
        for_each = try(rule.value.filters, {})

        content {
          prefix_match = filters.value.prefix_match
          blob_types   = filters.value.blob_types
          
          dynamic "match_blob_index_tag" {
            for_each = try(filters.match_blob_index_tag, {})

            content {
              name      = match_blob_index_tag.value.name
              operation = match_blob_index_tag.value.operation
              value     = match_blob_index_tag.value.value
            }
          }
        }

      }
      actions {
        dynamic "base_blob" {
          for_each = try(rule.value.actions.base_blob, {})

          content {
            tier_to_cool_after_days_since_modification_greater_than    = base_blob.value.tier_to_cool_after_days_since_modification_greater_than
            tier_to_archive_after_days_since_modification_greater_than = base_blob.value.tier_to_archive_after_days_since_modification_greater_than
            delete_after_days_since_modification_greater_than          = base_blob.value.delete_after_days_since_modification_greater_than
          }
        }

        dynamic "snapshot" {
          for_each = try(rule.value.actions.snapshot, {})

          content {
            change_tier_to_archive_after_days_since_creation = snapshot.value.change_tier_to_archive_after_days_since_creation
            change_tier_to_cool_after_days_since_creation    = snapshot.value.change_tier_to_cool_after_days_since_creation
            delete_after_days_since_creation_greater_than    = snapshot.value.delete_after_days_since_creation_greater_than
          }
        }

        dynamic "version" {
          for_each = try(rule.value.actions.version, {})

          content {
            change_tier_to_archive_after_days_since_creation = version.value.change_tier_to_archive_after_days_since_creation
            change_tier_to_cool_after_days_since_creation    = version.value.change_tier_to_cool_after_days_since_creation
            delete_after_days_since_creation                 = version.value.delete_after_days_since_creation
          }
        }
      }
    }
  }
}