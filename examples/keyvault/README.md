module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# key_vault

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Key Vault. Changing this forces a new resource to be created.||True|
| region |The region_key where the resource will be deployed|String|True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|sku_name| The Name of the SKU used for this Key Vault. Possible values are `standard` and `premium`.||True|
|tenant_id| The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.||True|
|access_policy| [A list](/docs/configuration/attr-as-blocks.html) of up to 16 objects describing access policies, as described below.| Block |False|
|enabled_for_deployment| Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to `false`.||False|
|enabled_for_disk_encryption| Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to `false`.||False|
|enabled_for_template_deployment| Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to `false`.||False|
|enable_rbac_authorization| Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to `false`.||False|
|network_acls| A `network_acls` block as defined below.| Block |False|
|purge_protection_enabled| Is Purge Protection enabled for this Key Vault? Defaults to `false`.||False|
|soft_delete_retention_days| The number of days that items should be retained for once soft-deleted. This value can be between `7` and `90` (the default) days.||False|
|contact| One or more `contact` block as defined below.| Block |False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|access_policy|tenant_id| The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. Must match the `tenant_id` used above.|||True|
|access_policy|object_id| The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies.|||True|
|access_policy|application_id| The object ID of an Application in Azure Active Directory.|||False|
|access_policy|certificate_permissions| List of certificate permissions, must be one or more from the following: `Backup`, `Create`, `Delete`, `DeleteIssuers`, `Get`, `GetIssuers`, `Import`, `List`, `ListIssuers`, `ManageContacts`, `ManageIssuers`, `Purge`, `Recover`, `Restore`, `SetIssuers` and `Update`.|||False|
|access_policy|key_permissions| List of key permissions, must be one or more from the following: `Backup`, `Create`, `Decrypt`, `Delete`, `Encrypt`, `Get`, `Import`, `List`, `Purge`, `Recover`, `Restore`, `Sign`, `UnwrapKey`, `Update`, `Verify` and `WrapKey`.|||False|
|access_policy|secret_permissions| List of secret permissions, must be one or more from the following: `Backup`, `Delete`, `Get`, `List`, `Purge`, `Recover`, `Restore` and `Set`.|||False|
|access_policy|storage_permissions| List of storage permissions, must be one or more from the following: `Backup`, `Delete`, `DeleteSAS`, `Get`, `GetSAS`, `List`, `ListSAS`, `Purge`, `Recover`, `RegenerateKey`, `Restore`, `Set`, `SetSAS` and `Update`.|||False|
|network_acls|bypass| Specifies which traffic can bypass the network rules. Possible values are `AzureServices` and `None`.|||True|
|network_acls|default_action| The Default Action to use when no rules match from `ip_rules` / `virtual_network_subnet_ids`. Possible values are `Allow` and `Deny`.|||True|
|network_acls|ip_rules| One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.|||False|
|network_acls|virtual_network_subnet_ids| One or more Subnet ID's which should be able to access this Key Vault.|||False|
|contact|email| E-mail address of the contact.|||True|
|contact|name| Name of the contact.|||False|
|contact|phone| Phone number of the contact.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Key Vault.|||
|vault_uri|The URI of the Key Vault, used for performing operations on keys and secrets.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# key_vault_key

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Key Vault Key. Changing this forces a new resource to be created.||True|
|key_vault|The `key_vault` block as defined below.|Block|True|
|key_type| Specifies the Key Type to use for this Key Vault Key. Possible values are `EC` (Elliptic Curve), `EC-HSM`, `Oct` (Octet), `RSA` and `RSA-HSM`. Changing this forces a new resource to be created.||True|
|key_size| Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. *Note*: This field is required if `key_type` is `RSA` or `RSA-HSM`. Changing this forces a new resource to be created.||False|
|curve| Specifies the curve to use when creating an `EC` key. Possible values are `P-256`, `P-256K`, `P-384`, and `P-521`. This field will be required in a future release if `key_type` is `EC` or `EC-HSM`. The API will default to `P-256` if nothing is specified. Changing this forces a new resource to be created.||False|
|key_opts| A list of JSON web key operations. Possible values include: `decrypt`, `encrypt`, `sign`, `unwrapKey`, `verify` and `wrapKey`. Please note these values are case sensitive.||True|
|not_before_date| Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').||False|
|expiration_date| Expiration UTC datetime (Y-m-d'T'H:M:S'Z').||False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|key_vault| key | Key for  key_vault||| Required if  |
|key_vault| lz_key |Landing Zone Key in wich the key_vault is located|||True|
|key_vault| id | The id of the key_vault |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The Key Vault Key ID.|||
|version|The current version of the Key Vault Key.|||
|versionless_id|The Base ID of the Key Vault Key.|||
|n|The RSA modulus of this Key Vault Key.|||
|e|The RSA public exponent of this Key Vault Key.|||
|x|The EC X component of this Key Vault Key.|||
|y|The EC Y component of this Key Vault Key.|||
|public_key_pem|The PEM encoded public key of this Key Vault Key.|||
|public_key_openssh|The OpenSSH encoded public key of this Key Vault Key.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# key_vault_access_policy

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|key_vault|The `key_vault` block as defined below.|Block|True|
|tenant_id| The Azure Active Directory tenant ID that should be used||True|
|object_id| The object ID of a user, service principal or security||True|
|application_id| The object ID of an Application in Azure Active Directory.||False|
|certificate_permissions| List of certificate permissions, must be one or more from the following: `Backup`, `Create`, `Delete`, `DeleteIssuers`, `Get`, `GetIssuers`, `Import`, `List`, `ListIssuers`, `ManageContacts`, `ManageIssuers`, `Purge`, `Recover`, `Restore`, `SetIssuers` and `Update`.||False|
|key_permissions| List of key permissions, must be one or more from the following: `Backup`, `Create`, `Decrypt`, `Delete`, `Encrypt`, `Get`, `Import`, `List`, `Purge`, `Recover`, `Restore`, `Sign`, `UnwrapKey`, `Update`, `Verify` and `WrapKey`.||False|
|secret_permissions| List of secret permissions, must be one or more from the following: `Backup`, `Delete`, `Get`, `List`, `Purge`, `Recover`, `Restore` and `Set`.||False|
|storage_permissions| List of storage permissions, must be one or more from the following: `Backup`, `Delete`, `DeleteSAS`, `Get`, `GetSAS`, `List`, `ListSAS`, `Purge`, `Recover`, `RegenerateKey`, `Restore`, `Set`, `SetSAS` and `Update`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|key_vault| key | Key for  key_vault||| Required if  |
|key_vault| lz_key |Landing Zone Key in wich the key_vault is located|||True|
|key_vault| id | The id of the key_vault |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|Key Vault Access Policy ID.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# key_vault_certificate_issuer

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|key_vault|The `key_vault` block as defined below.|Block|True|
|name| The name which should be used for this Key Vault Certificate Issuer. Changing this forces a new Key Vault Certificate Issuer to be created.||True|
|provider_name| The name of the third-party Certificate Issuer. Possible values are: `DigiCert`, `GlobalSign`, `OneCertV2-PrivateCA`, `OneCertV2-PublicCA` and `SslAdminV2`.||True|
|org_id| The ID of the organization as provided to the issuer. ||False|
|account_id| The account number with the third-party Certificate Issuer.||False|
|admin| One or more `admin` blocks as defined below.| Block |False|
|password| The password associated with the account and organization ID at the third-party Certificate Issuer. If not specified, will not overwrite any previous value.||False|
|email_address| E-mail address of the admin.||True|
|first_name| First name of the admin.||False|
|last_name| Last name of the admin.||False|
|phone| Phone number of the admin.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|key_vault| key | Key for  key_vault||| Required if  |
|key_vault| lz_key |Landing Zone Key in wich the key_vault is located|||True|
|key_vault| id | The id of the key_vault |||True|
|admin|email_address| E-mail address of the admin.|||True|
|admin|first_name| First name of the admin.|||False|
|admin|last_name| Last name of the admin.|||False|
|admin|phone| Phone number of the admin.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Key Vault Certificate Issuer.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# key_vault_secret

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created.||True|
|value| Specifies the value of the Key Vault Secret.||True|
|key_vault|The `key_vault` block as defined below.|Block|True|
|content_type| Specifies the content type for the Key Vault Secret.||False|
|tags| A mapping of tags to assign to the resource.||False|
|not_before_date| Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').||False|
|expiration_date| Expiration UTC datetime (Y-m-d'T'H:M:S'Z').||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|key_vault| key | Key for  key_vault||| Required if  |
|key_vault| lz_key |Landing Zone Key in wich the key_vault is located|||True|
|key_vault| id | The id of the key_vault |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The Key Vault Secret ID.|||
|version|The current version of the Key Vault Secret.|||
|versionless_id|The Base ID of the Key Vault Secret.|||
