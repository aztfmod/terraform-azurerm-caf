

module "private_dns" {
  source   = "./modules/networking/private-dns"
  for_each = local.networking.private_dns

  global_settings     = local.global_settings
  name                = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  records             = try(each.value.records, {})
  vnet_links          = try(each.value.vnet_links, {})
  tags                = try(each.value.tags, null)
  tfstates            = var.tfstates
  use_msi             = var.use_msi
  vnets               = local.combined_objects.networking
}

output "private_dns" {
  value = module.private_dns
}