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

# #
# # Get remote ase vnet
# #
# data "terraform_remote_state" "vnet_dns" {
#   for_each = {
#     for key, value in var.settings.private_dns_records.a_records : key => value
#     if try(value.remote_tfstate, null) != null
#   }

#   backend = "azurerm"
#   config = {
#     storage_account_name = var.tfstates[each.value.remote_tfstate.tfstate_key].storage_account_name
#     container_name       = var.tfstates[each.value.remote_tfstate.tfstate_key].container_name
#     resource_group_name  = var.tfstates[each.value.remote_tfstate.tfstate_key].resource_group_name
#     key                  = var.tfstates[each.value.remote_tfstate.tfstate_key].key
#     use_msi              = var.use_msi
#     subscription_id      = var.use_msi ? var.tfstates[each.value.remote_tfstate.tfstate_key].subscription_id : null
#     tenant_id            = var.use_msi ? var.tfstates[each.value.remote_tfstate.tfstate_key].tenant_id : null
#   }
# }
