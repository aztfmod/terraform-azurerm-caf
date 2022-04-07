dynamic_keyvault_secrets = {
  host_pool_secrets = {
    hostpool-token = {
      # this secret is retrieved automatically from the module run output
      secret_name   = "newwvd-hostpool-token"
      output_key    = "wvd_host_pools"
      resource_key  = "wvd_hp1"
      attribute_key = "token"
    }
  }
  example_vm_rg1 = { # Key of the keyvault
    # below are examples of manual seeding, not recommended to keep secrets in varfiles, just to illustrate the capability and integration features.
    vmadmin-username = {
      secret_name = "vmadmin-username"
      value       = "vmadmin"
    }
    vmadmin-password = {
      secret_name = "vmadmin-password"
      value       = "Very@Str5ngP!44w0rdToChaNge#"
    }
    domain-join-username = {
      secret_name = "domain-join-username"
      value       = "domainjoinuser@contoso.com"
    }
    domain-join-password = {
      secret_name = "domain-join-password"
      value       = "MyDoma1nVery@Str5ngP!44w0rdToChaNge#"
    }
  }
}


