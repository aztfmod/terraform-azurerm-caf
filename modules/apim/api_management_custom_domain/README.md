module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# api_management_custom_domain

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|api_management|The `api_management` block as defined below.|Block|True|
|developer_portal| One or more `developer_portal` blocks as defined below.| Block |False|
|management| One or more `management` blocks as defined below.| Block |False|
|portal| One or more `portal` blocks as defined below.| Block |False|
|proxy| One or more `proxy` blocks as defined below.| Block |False|
|scm| One or more `scm` blocks as defined below.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|api_management| key | Key for  api_management||| Required if  |
|api_management| lz_key |Landing Zone Key in wich the api_management is located|||True|
|api_management| id | The id of the api_management |||True|
|developer_portal|host_name| The Hostname to use for the corresponding endpoint.|||True|
|developer_portal|certificate| The Base64 Encoded Certificate. (Mutually exclusive with `key_vault_id`.)|||False|
|developer_portal|certificate_password| The password associated with the certificate provided above.|||False|
|developer_portal|key_vault_id| The ID of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.|||False|
|developer_portal|negotiate_client_certificate| Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.|||False|
|management|host_name| The Hostname to use for the corresponding endpoint.|||True|
|management|certificate| The Base64 Encoded Certificate. (Mutually exclusive with `key_vault_id`.)|||False|
|management|certificate_password| The password associated with the certificate provided above.|||False|
|management|key_vault_id| The ID of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.|||False|
|management|negotiate_client_certificate| Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.|||False|
|portal|host_name| The Hostname to use for the corresponding endpoint.|||True|
|portal|certificate| The Base64 Encoded Certificate. (Mutually exclusive with `key_vault_id`.)|||False|
|portal|certificate_password| The password associated with the certificate provided above.|||False|
|portal|key_vault_id| The ID of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.|||False|
|portal|negotiate_client_certificate| Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.|||False|
|proxy|host_name| The Hostname to use for the API Proxy Endpoint.|||True|
|proxy|certificate| The Base64 Encoded Certificate. (Mutually exclusive with `key_vault_id`.)|||False|
|proxy|certificate_password| The password associated with the certificate provided above.|||False|
|proxy|default_ssl_binding| Is the certificate associated with this Hostname the Default SSL Certificate? This is used when an SNI header isn't specified by a client. Defaults to false.|||False|
|proxy|key_vault_id| The ID of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.|||False|
|proxy|negotiate_client_certificate| Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.|||False|
|scm|host_name| The Hostname to use for the corresponding endpoint.|||True|
|scm|certificate| The Base64 Encoded Certificate. (Mutually exclusive with `key_vault_id`.)|||False|
|scm|certificate_password| The password associated with the certificate provided above.|||False|
|scm|key_vault_id| The ID of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.|||False|
|scm|negotiate_client_certificate| Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the API Management Custom Domain.|||
