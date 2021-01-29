module "caf" {
  source          = "../../../../../"
  global_settings = var.global_settings
  resource_groups = var.resource_groups
  tags            = var.tags

  managed_identities = var.managed_identities
  role_mapping       = var.role_mapping

  networking = {
    vnets               = var.vnets
    dns_zones           = var.dns_zones
    dns_zone_records    = var.dns_zone_records
    public_ip_addresses = var.public_ip_addresses
  }
}

