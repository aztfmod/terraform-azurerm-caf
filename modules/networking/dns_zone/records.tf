module "records" {
  source     = "./records"
  count      = try(var.settings.records, null) == null ? 0 : 1
  depends_on = [azurerm_dns_zone.dns_zone]

  base_tags           = var.base_tags
  client_config       = var.client_config
  resource_group_name = var.resource_group_name
  records             = var.settings.records
  resource_ids        = var.resource_ids
  zone_name           = local.dns_zone_name
}