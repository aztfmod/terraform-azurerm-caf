module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# frontdoor_custom_https_configuration

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|frontend_endpoint_id| The ID of the FrontDoor Frontend Endpoint which this configuration refers to.||True|
|custom_https_provisioning_enabled| Should the HTTPS protocol be enabled for this custom domain associated with the Front Door?||True|
|custom_https_configuration| A `custom_https_configuration` block as defined above.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|custom_https_configuration|certificate_source| Certificate source to encrypted `HTTPS` traffic with. Allowed values are `FrontDoor` or `AzureKeyVault`. Defaults to `FrontDoor`.|||False|
|custom_https_configuration|azure_key_vault_certificate_vault_id| The ID of the Key Vault containing the SSL certificate.|||True|
|custom_https_configuration|azure_key_vault_certificate_secret_name| The name of the Key Vault secret representing the full certificate PFX.|||True|
|custom_https_configuration|azure_key_vault_certificate_secret_version| The version of the Key Vault secret representing the full certificate PFX. Defaults to `Latest`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Azure Front Door Custom Https Configuration.|||
|custom_https_configuration|A `custom_https_configuration` block as defined below.|||
|minimum_tls_version|Minimum client TLS version supported.|||
