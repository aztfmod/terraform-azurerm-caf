output id {
  value     = azuread_group.group.id
  sensitive = true
}

output tenant_id {
  value     = data.azuread_client_config.current.tenant_id
  sensitive = true
}

output name {
  value     = azuread_group.group.name
  sensitive = true
}