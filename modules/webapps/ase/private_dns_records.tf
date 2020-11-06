resource "azurerm_private_dns_a_record" "a_records" {
  depends_on = [
    azurerm_template_deployment.ase
  ]
  for_each = try(var.settings.private_dns_records.a_records, {})

  name                = each.value.name == "" ? azurecaf_name.ase.result : format("%s.%s", each.value.name, azurecaf_name.ase.result)
  resource_group_name = lookup(each.value, "lz_key", null) == null ? var.private_dns[each.value.private_dns_key].resource_group_name : var.private_dns[each.value.lz_key][each.value.private_dns_key].resource_group_name
  zone_name           = lookup(each.value, "lz_key", null) == null ? var.private_dns[each.value.private_dns_key].name : var.private_dns[each.value.lz_key][each.value.private_dns_key].name
  ttl                 = each.value.ttl
  records             = [data.external.ase_ilb_ip.result.internalIpAddress]
  tags                = merge(try(each.value.tags, {}), local.tags)
}

