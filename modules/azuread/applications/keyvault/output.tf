
output id {
  value     = try(data.terraform_remote_state.keyvaults["remote_tfstate"].outputs[var.settings.remote_tfstate.output_key][var.settings.remote_tfstate.lz_key][var.settings.keyvault_key].id, var.keyvault_id)
  sensitive = true
}

# output secret_prefix_client_id {
#   value = azurerm_key_vault_secret.client_id.name
#   sensitive = true
# }

# output secret_prefix_tenant_id {
#   value = azurerm_key_vault_secret.tenant_id.name
#   sensitive = true
# }

output secret_name_client_secret {
  value     = azurerm_key_vault_secret.client_secret.name
  sensitive = true
}
