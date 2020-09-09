
# data "terraform_remote_state" "vnet_links" {
#   for_each = {
#     for key, vnet_link in local.networking.private_dns.vnet_links : key => vnet_link
#     if try(vnet_link.tfstate_key, null) != null
#   }

#   backend = "azurerm"
#   config = {
#     storage_account_name = var.tfstates[each.value.tfstate_key].storage_account_name
#     container_name       = var.tfstates[each.value.tfstate_key].container_name
#     resource_group_name  = var.tfstates[each.value.tfstate_key].resource_group_name
#     key                  = var.tfstates[each.value.tfstate_key].key
#     use_msi              = var.use_msi
#     subscription_id      = var.use_msi ? var.tfstates[each.value.tfstate_key].subscription_id : null
#     tenant_id            = var.use_msi ? var.tfstates[each.value.tfstate_key].tenant_id : null
#   }
# }

# locals {
#   private_dns_links = {
#     for_each  = local.networking.private_dns.vnet_links

#     name      = each.value.name
#     vnet_id   = try(module.networking[each.value.to.vnet_key].id, data.terraform_remote_state.vnet_links[each.key].outputs[each.value.output_key][each.value.lz_key][each.value.vnet_key].id)
#   }
# }


module "private_dns" {
  source   = "./modules/networking/private-dns"
  for_each = local.networking.private_dns

  global_settings     = local.global_settings
  name                = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  records             = try(each.value.records, {})
  vnet_links          = try(each.value.vnet_links, {})
  tags                = try(each.value.tags, null)
}

output "private_dns" {
  value = module.private_dns
}