module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# active_directory_domain_service

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|domain_name| The Active Directory domain to use. See [official documentation](https://docs.microsoft.com/en-us/azure/active-directory-domain-services/tutorial-create-instance#create-a-managed-domain) for constraints and recommendations.||True|
|filtered_sync_enabled|Whether to enable group-based filtered sync (also called scoped synchronisation). Defaults to `false`.||False|
|secure_ldap| A `secure_ldap` block as defined below.| Block |False|
| region |The region_key where the resource will be deployed|String|True|
|name| The display name for your managed Active Directory Domain Service resource. Changing this forces a new resource to be created.||True|
|notifications| A `notifications` block as defined below.| Block |False|
|initial_replica_set| An `initial_replica_set` block as defined below. The initial replica set inherits the same location as the Domain Service resource.| Block |True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|security| A `security` block as defined below.| Block |False|
|sku| The SKU to use when provisioning the Domain Service resource. One of `Standard`, `Enterprise` or `Premium`.||True|
|tags| A mapping of tags assigned to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|secure_ldap|enabled| Whether to enable secure LDAP for the managed domain. Defaults to `false`.|||True|
|secure_ldap|external_access_enabled| Whether to enable external access to LDAPS over the Internet. Defaults to `false`.|||False|
|secure_ldap|pfx_certificate| The certificate/private key to use for LDAPS, as a base64-encoded TripleDES-SHA1 encrypted PKCS#12 bundle (PFX file).|||True|
|secure_ldap|pfx_certificate_password| The password to use for decrypting the PKCS#12 bundle (PFX file).|||True|
|notifications|additional_recipients| A list of additional email addresses to notify when there are alerts in the managed domain.|||False|
|notifications|notify_dc_admins| Whether to notify members of the _AAD DC Administrators_ group when there are alerts in the managed domain.|||False|
|notifications|notify_global_admins| Whether to notify all Global Administrators when there are alerts in the managed domain.|||False|
|initial_replica_set|subnet_id| The ID of the subnet in which to place the initial replica set.|||True|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|security|ntlm_v1_enabled| Whether to enable legacy NTLM v1 support. Defaults to `false`.|||False|
|security|sync_kerberos_passwords| Whether to synchronize Kerberos password hashes to the managed domain. Defaults to `false`.|||False|
|security|sync_ntlm_passwords| Whether to synchronize NTLM password hashes to the managed domain. Defaults to `false`.|||False|
|security|sync_on_prem_passwords| Whether to synchronize on-premises password hashes to the managed domain. Defaults to `false`.|||False|
|security|tls_v1_enabled| Whether to enable legacy TLS v1 support. Defaults to `false`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Domain Service.|||
|deployment_id|A unique ID for the managed domain deployment.|||
|resource_id|The Azure resource ID for the domain service.|||
