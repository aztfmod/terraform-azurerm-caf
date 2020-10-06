output diagnostics {
  value     = local.diagnostics
  sensitive = true
}

output client_config {
  value = {
    tenant_id       = local.client_config.tenant_id
    subscription_id = local.client_config.subscription_id
  }
  sensitive = true
}