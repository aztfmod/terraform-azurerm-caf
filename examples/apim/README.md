

# api_management

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the API Management Service. Changing this forces a new resource to be created.||True|
| region |The region_key where the resource will be deployed|String|True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|publisher_name| The name of publisher/company.||True|
|publisher_email| The email of publisher/company.||True|
|sku_name| `sku_name` is a string consisting of two parts separated by an underscore(\_). The first part is the `name`, valid values include: `Consumption`, `Developer`, `Basic`, `Standard` and `Premium`. The second part is the `capacity` (e.g. the number of deployed units of the `sku`), which must be a positive `integer` (e.g. `Developer_1`).||True|
|additional_location| One or more `additional_location` blocks as defined below.| Block |False|
|certificate| One or more (up to 10) `certificate` blocks as defined below.| Block |False|
|client_certificate_enabled| Enforce a client certificate to be presented on each request to the gateway? This is only supported when sku type is `Consumption`.||False|
|gateway_disabled| Disable the gateway in main region? This is only supported when `additional_location` is set.||False|
|min_api_version|  The version which the control plane API calls to API Management service are limited with version equal to or newer than.||False|
|zones| A list of availability zones.||False|
|identity| An `identity` block as defined below.| Block |False|
|hostname_configuration| A `hostname_configuration` block as defined below.| Block |False|
|notification_sender_email| Email address from which the notification will be sent.||False|
|policy| A `policy` block as defined below.| Block |False|
|protocols| A `protocols` block as defined below.| Block |False|
|security| A `security` block as defined below.| Block |False|
|sign_in| A `sign_in` block as defined below.| Block |False|
|sign_up| A `sign_up` block as defined below.| Block |False|
|tenant_access| A `tenant_access` block as defined below.| Block |False|
|virtual_network_type| The type of virtual network you want to use, valid values include: `None`, `External`, `Internal`. ||False|
|virtual_network_configuration| A `virtual_network_configuration` block as defined below. Required when `virtual_network_type` is `External` or `Internal`.| Block |False|
|tags| A mapping of tags assigned to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|additional_location|location| The name of the Azure Region in which the API Management Service should be expanded to.|||True|
|additional_location|virtual_network_configuration| A `virtual_network_configuration` block as defined below.  Required when `virtual_network_type` is `External` or `Internal`.|||False|
|virtual_network_configuration|subnet_id| The id of the subnet that will be used for the API Management.|||True|
|certificate|encoded_certificate| The Base64 Encoded PFX or Base64 Encoded X.509 Certificate.|||True|
|certificate|store_name| The name of the Certificate Store where this certificate should be stored. Possible values are `CertificateAuthority` and `Root`.|||True|
|certificate|certificate_password| The password for the certificate.|||False|
|identity|type| Specifies the type of Managed Service Identity that should be configured on this API Management Service. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both).|||True|
|identity|identity_ids| A list of IDs for User Assigned Managed Identity resources to be assigned.|||False|
|hostname_configuration|management| One or more `management` blocks as documented below.|||False|
|hostname_configuration|portal| One or more `portal` blocks as documented below.|||False|
|hostname_configuration|developer_portal| One or more `developer_portal` blocks as documented below.|||False|
|hostname_configuration|proxy| One or more `proxy` blocks as documented below.|||False|
|proxy|default_ssl_binding| Is the certificate associated with this Hostname the Default SSL Certificate? This is used when an SNI header isn't specified by a client. Defaults to `false`.|||False|
|proxy|host_name| The Hostname to use for the Management API.|||True|
|proxy|key_vault_id| The ID of the Key Vault Secret containing the SSL Certificate, which must be should be of the type `application/x-pkcs12`.|||False|
|proxy|certificate| The Base64 Encoded Certificate.|||False|
|certificate|encoded_certificate| The Base64 Encoded PFX or Base64 Encoded X.509 Certificate.|||True|
|certificate|store_name| The name of the Certificate Store where this certificate should be stored. Possible values are `CertificateAuthority` and `Root`.|||True|
|certificate|certificate_password| The password for the certificate.|||False|
|proxy|certificate_password| The password associated with the certificate provided above.|||False|
|proxy|negotiate_client_certificate| Should Client Certificate Negotiation be enabled for this Hostname? Defaults to `false`.|||False|
|hostname_configuration|scm| One or more `scm` blocks as documented below.|||False|
|policy|xml_content| The XML Content for this Policy.|||False|
|policy|xml_link| A link to an API Management Policy XML Document, which must be publicly available.|||False|
|protocols|enable_http2| Should HTTP/2 be supported by the API Management Service? Defaults to `false`.|||False|
|security|enable_backend_ssl30| Should SSL 3.0 be enabled on the backend of the gateway? Defaults to `false`.|||False|
|security|enable_backend_tls10| Should TLS 1.0 be enabled on the backend of the gateway? Defaults to `false`.|||False|
|security|enable_backend_tls11| Should TLS 1.1 be enabled on the backend of the gateway? Defaults to `false`.|||False|
|security|enable_frontend_ssl30| Should SSL 3.0 be enabled on the frontend of the gateway? Defaults to `false`.|||False|
|security|enable_frontend_tls10| Should TLS 1.0 be enabled on the frontend of the gateway? Defaults to `false`.|||False|
|security|enable_frontend_tls11| Should TLS 1.1 be enabled on the frontend of the gateway? Defaults to `false`.|||False|
|security|tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled| Should the `TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA` cipher be enabled? Defaults to `false`.|||False|
|security|tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled| Should the `TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA` cipher be enabled? Defaults to `false`.|||False|
|security|tls_ecdheRsa_with_aes128_cbc_sha_ciphers_enabled| Should the `TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA` cipher be enabled? Defaults to `false`.|||False|
|security|tls_ecdheRsa_with_aes256_cbc_sha_ciphers_enabled| Should the `TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA` cipher be enabled? Defaults to `false`.|||False|
|security|tls_rsa_with_aes128_cbc_sha256_ciphers_enabled| Should the `TLS_RSA_WITH_AES_128_CBC_SHA256` cipher be enabled? Defaults to `false`.|||False|
|security|tls_rsa_with_aes128_cbc_sha_ciphers_enabled| Should the `TLS_RSA_WITH_AES_128_CBC_SHA` cipher be enabled? Defaults to `false`.|||False|
|security|tls_rsa_with_aes128_gcm_sha256_ciphers_enabled| Should the `TLS_RSA_WITH_AES_128_GCM_SHA256` cipher be enabled? Defaults to `false`.|||False|
|security|tls_rsa_with_aes256_cbc_sha256_ciphers_enabled| Should the `TLS_RSA_WITH_AES_256_CBC_SHA256` cipher be enabled? Defaults to `false`.|||False|
|security|tls_rsa_with_aes256_cbc_sha_ciphers_enabled| Should the `TLS_RSA_WITH_AES_256_CBC_SHA` cipher be enabled? Defaults to `false`.|||False|
|security|enable_triple_des_ciphers| Should the `TLS_RSA_WITH_3DES_EDE_CBC_SHA` cipher be enabled for alL TLS versions (1.0, 1.1 and 1.2)? Defaults to `false`.|||False|
|security|triple_des_ciphers_enabled| Should the `TLS_RSA_WITH_3DES_EDE_CBC_SHA` cipher be enabled for alL TLS versions (1.0, 1.1 and 1.2)? Defaults to `false`.|||False|
|security|disable_backend_ssl30| Should SSL 3.0 be disabled on the backend of the gateway? This property was mistakenly inverted and `true` actually enables it. Defaults to `false`.|||False|
|security|disable_backend_tls10| Should TLS 1.0 be disabled on the backend of the gateway? This property was mistakenly inverted and `true` actually enables it. Defaults to `false`.|||False|
|security|disable_backend_tls11| Should TLS 1.1 be disabled on the backend of the gateway? This property was mistakenly inverted and `true` actually enables it. Defaults to `false`.|||False|
|security|disable_frontend_ssl30| Should SSL 3.0 be disabled on the frontend of the gateway? This property was mistakenly inverted and `true` actually enables it. Defaults to `false`.|||False|
|security|disable_frontend_tls10| Should TLS 1.0 be disabled on the frontend of the gateway? This property was mistakenly inverted and `true` actually enables it. Defaults to `false`.|||False|
|security|disable_frontend_tls11| Should TLS 1.1 be disabled on the frontend of the gateway? This property was mistakenly inverted and `true` actually enables it. Defaults to `false`.|||False|
|sign_in|enabled| Should anonymous users be redirected to the sign in page?|||True|
|sign_up|enabled| Can users sign up on the development portal?|||True|
|sign_up|terms_of_service| A `terms_of_service` block as defined below.|||True|
|terms_of_service|consent_required| Should the user be asked for consent during sign up?|||True|
|terms_of_service|enabled| Should Terms of Service be displayed during sign up?.|||True|
|terms_of_service|text| The Terms of Service which users are required to agree to in order to sign up.|||True|
|tenant_access|enabled| Should the access to the management api be enabled?|||True|
|virtual_network_configuration|subnet_id| The id of the subnet that will be used for the API Management.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the API Management Service.|||
|additional_location|Zero or more `additional_location` blocks as documented below.|||
|gateway_url|The URL of the Gateway for the API Management Service.|||
|gateway_regional_url|The Region URL for the Gateway of the API Management Service.|||
|identity|An `identity` block as defined below.|||
|management_api_url|The URL for the Management API associated with this API Management service.|||
|portal_url|The URL for the Publisher Portal associated with this API Management service.|||
|developer_portal_url|The URL for the Developer Portal associated with this API Management service.|||
|public_ip_addresses|The Public IP addresses of the API Management Service.|||
|private_ip_addresses|The Private IP addresses of the API Management Service.|||
|scm_url|The URL for the SCM (Source Code Management) Endpoint associated with this API Management service.|||
|tenant_access|The `tenant_access` block as documented below.|||
