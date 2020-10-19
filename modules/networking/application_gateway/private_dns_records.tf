# resource "azurerm_private_dns_a_record" "a_records" {
#   depends_on = [
#     azurerm_template_deployment.ase
#   ]
#   for_each = try(var.settings.private_dns_records.a_records, {})

#   name                = each.value.name
#   resource_group_name = lookup(each.value, "remote_tfstate", null) == null ? var.private_dns[each.value.private_dns_key].resource_group_name : data.terraform_remote_state.ase_vnet_dns[each.key].outputs[each.value.remote_tfstate.output_key][each.value.private_dns_key].resource_group_name
#   zone_name           = lookup(each.value, "remote_tfstate", null) == null ? var.private_dns[each.value.private_dns_key].name : data.terraform_remote_state.ase_vnet_dns[each.key].outputs[each.value.remote_tfstate.output_key][each.value.private_dns_key].name
#   ttl                 = each.value.ttl
#   records             = [data.external.ase_ilb_ip.result.internalIpAddress]
#   tags                = try(each.value.tags, {})
# }
