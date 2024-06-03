data "azurecaf_name" "managed_disk" {
  for_each = try(var.settings.managed_disks, {})

  name          = each.value.name
  resource_type = "azurerm_managed_disk"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


resource "azurerm_managed_disk" "managed_disk" {
  for_each = try(var.settings.managed_disks, {})


  name                   = data.azurecaf_name.managed_disk[each.key].result
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)
  storage_account_type   = each.value.storage_account_type
  create_option          = each.value.create_option
  disk_size_gb           = each.value.disk_size_gb
  zone                   = try(each.value.zone, each.value.zones[0], null)
  disk_iops_read_write   = try(each.value.disk_iops_read_write, null)
  disk_mbps_read_write   = try(each.value.disk.disk_mbps_read_write, null)
  disk_iops_read_only    = try(each.value.disk_iops_read_only, null)
  disk_mbps_read_only    = try(each.value.disk_mbps_read_only, null)
  upload_size_bytes      = try(each.value.upload_size_bytes, null)
  edge_zone              = try(each.value.edge_zone, null)
  encryption_settings    = try(each.value.encryption_settings, null)
  tags                   = merge(local.tags, try(each.value.tags, {}))
  disk_encryption_set_id = try(each.value.disk_encryption_set_key, null) == null ? null : var.disk_encryption_sets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.disk_encryption_set_key].id

  lifecycle {
    ignore_changes = [
      name, #for ASR disk restores
    ]
  }

}
