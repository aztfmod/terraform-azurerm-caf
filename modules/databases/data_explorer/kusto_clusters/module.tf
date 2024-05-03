resource "azurecaf_name" "kusto" {
  name          = var.settings.name
  resource_type = "azurerm_kusto_cluster"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Last review :  AzureRM version 2.77.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster

resource "azurerm_kusto_cluster" "kusto" {
  name                = azurecaf_name.kusto.result
  location            = var.location
  resource_group_name = var.resource_group_name
  dynamic "sku" {
    for_each = try(var.settings.sku, null) != null ? [var.settings.sku] : []

    content {
      name     = sku.value.name
      capacity = lookup(sku.value, "capacity", null)
    }
  }
  double_encryption_enabled = try(var.settings.double_encryption_enabled, null)
  dynamic "identity" {
    for_each = try(var.settings.identity, false) == false ? [] : [1]

    content {
      type         = var.settings.identity.type
      identity_ids = local.managed_identities
    }
  }
  disk_encryption_enabled     = try(var.settings.enable_disk_encryption, var.settings.disk_encryption_enabled, null)
  streaming_ingestion_enabled = try(var.settings.enable_streaming_ingest, var.settings.streaming_ingestion_enabled, null)
  purge_enabled               = try(var.settings.enable_purge, var.settings.purge_enabled, null)
  dynamic "virtual_network_configuration" {
    for_each = try(var.settings.virtual_network_configuration, null) != null ? [var.settings.virtual_network_configuration] : []
    content {
      subnet_id                    = can(virtual_network_configuration.value.subnet_id) || can(virtual_network_configuration.value.subnet_key) == false ? try(virtual_network_configuration.value.subnet_id, null) : try(virtual_network_configuration.value.vnet_key, null) == null ? null : var.combined_resources.vnets[try(virtual_network_configuration.value.lz_key, var.client_config.landingzone_key)][virtual_network_configuration.value.vnet_key].subnets[virtual_network_configuration.value.subnet_key].id
      engine_public_ip_id          = try(virtual_network_configuration.value.engine_public_ip.key, null) == null ? null : try(var.combined_resources.pips[try(virtual_network_configuration.value.engine_public_ip.lz_key, var.client_config.landingzone_key)][virtual_network_configuration.value.engine_public_ip.key].id, null)
      data_management_public_ip_id = try(virtual_network_configuration.value.data_management_public_ip.key, null) == null ? null : try(var.combined_resources.pips[try(virtual_network_configuration.value.data_management_public_ip.lz_key, var.client_config.landingzone_key)][virtual_network_configuration.value.data_management_public_ip.key].id, null)
    }
  }
  language_extensions = try(var.settings.language_extensions, null)
  dynamic "optimized_auto_scale" {
    for_each = try(var.settings.optimized_auto_scale, null) != null ? [var.settings.optimized_auto_scale] : []

    content {
      minimum_instances = optimized_auto_scale.value.minimum_instances
      maximum_instances = optimized_auto_scale.value.maximum_instances
    }
  }
  trusted_external_tenants      = try(var.settings.trusted_external_tenants, null)
  zones                         = try(var.settings.zones, null)
  engine                        = try(var.settings.engine, null)
  auto_stop_enabled             = try(var.settings.auto_stop_enabled, null)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, null)
  tags                          = local.tags
}
