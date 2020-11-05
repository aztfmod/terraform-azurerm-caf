
<<<<<<< HEAD
resource "azurerm_private_dns_a_record" "a_records" {
  for_each = try(var.settings.private_dns_records.a_records, {})

  name                = each.value.name
  resource_group_name = try(var.private_dns[each.value.lz_key][each.value.private_dns_key].resource_group_name, var.private_dns[var.client_config.landingzone_key][each.value.private_dns_key].resource_group_name)
  zone_name           = try(var.private_dns[each.value.lz_key][each.value.private_dns_key].name, var.private_dns[var.client_config.landingzone_key][each.value.private_dns_key].name)
  ttl                 = each.value.ttl
  records             = [local.private_ip_address]
  tags                = merge(local.tags, try(each.value.tags, {}))
}
=======
#   name                = each.value.name
#   resource_group_name = lookup(each.value, "remote_tfstate", null) == null ? var.private_dns[each.value.private_dns_key].resource_group_name : data.terraform_remote_state.ase_vnet_dns[each.key].outputs[each.value.remote_tfstate.output_key][each.value.private_dns_key].resource_group_name
#   zone_name           = lookup(each.value, "remote_tfstate", null) == null ? var.private_dns[each.value.private_dns_key].name : data.terraform_remote_state.ase_vnet_dns[each.key].outputs[each.value.remote_tfstate.output_key][each.value.private_dns_key].name
#   ttl                 = each.value.ttl
#   records             = [data.external.ase_ilb_ip.result.internalIpAddress]
#   tags                = try(each.value.tags, {})
# }
>>>>>>> 26c5af3f4a89bec1bca1fa9b304dd5dd5fe20aef
