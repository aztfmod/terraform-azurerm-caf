output "display_name" {
  value       = azuread_group.group.display_name
  description = "The display name for the group"
}
output "assignable_to_role" {
  value       = azuread_group.group.assignable_to_role
  description = "Indicates whether this group can be assigned to an Azure Active Directory role. This property can only be `true` for security-enabled groups."
}
output "auto_subscribe_new_members" {
  value       = azuread_group.group.auto_subscribe_new_members
  description = "Indicates whether new members added to the group will be auto-subscribed to receive email notifications."
}
output "behaviors" {
  value       = azuread_group.group.behaviors
  description = "The group behaviours for a Microsoft 365 group"
}
output "description" {
  value       = azuread_group.group.description
  description = "The description for the group"
}
output "dynamic_membership" {
  value       = azuread_group.group.dynamic_membership
  description = "An optional block to configure dynamic membership for the group. Cannot be used with `members`"
}
output "external_senders_allowed" {
  value       = azuread_group.group.external_senders_allowed
  description = "Indicates whether people external to the organization can send messages to the group."
}
output "hide_from_address_lists" {
  value       = azuread_group.group.hide_from_address_lists
  description = "Indicates whether the group is displayed in certain parts of the Outlook user interface: in the Address Book, in address lists for selecting message recipients, and in the Browse Groups dialog for searching groups."
}
output "hide_from_outlook_clients" {
  value       = azuread_group.group.hide_from_outlook_clients
  description = "Indicates whether the group is displayed in Outlook clients, such as Outlook for Windows and Outlook on the web."
}
output "mail_enabled" {
  value       = azuread_group.group.mail_enabled
  description = "Whether the group is a mail enabled, with a shared group mailbox. At least one of `mail_enabled` or `security_enabled` must be specified. A group can be mail enabled _and_ security enabled"
}
output "mail_nickname" {
  value       = azuread_group.group.mail_nickname
  description = "The mail alias for the group, unique in the organisation"
}
output "members" {
  value       = azuread_group.group.members
  description = "A set of members who should be present in this group. Supported object types are Users, Groups or Service Principals"
}
output "owners" {
  value       = azuread_group.group.owners
  description = "A set of owners who own this group. Supported object types are Users or Service Principals"
}
output "prevent_duplicate_names" {
  value       = azuread_group.group.prevent_duplicate_names
  description = "If `true`, will return an error if an existing group is found with the same name"
}
output "provisioning_options" {
  value       = azuread_group.group.provisioning_options
  description = "The group provisioning options for a Microsoft 365 group"
}
output "security_enabled" {
  value       = azuread_group.group.security_enabled
  description = "Whether the group is a security group for controlling access to in-app resources. At least one of `security_enabled` or `mail_enabled` must be specified. A group can be security enabled _and_ mail enabled"
}
output "theme" {
  value       = azuread_group.group.theme
  description = "The colour theme for a Microsoft 365 group"
}
output "types" {
  value       = azuread_group.group.types
  description = "A set of group types to configure for the group. `Unified` specifies a Microsoft 365 group. Required when `mail_enabled` is true"
}
output "visibility" {
  value       = azuread_group.group.visibility
  description = "Specifies the group join policy and group content visibility"
}
output "mail" {
  value       = azuread_group.group.mail
  description = "The SMTP address for the group"
}
output "object_id" {
  value       = azuread_group.group.object_id
  description = "The object ID of the group"
}
output "onpremises_domain_name" {
  value       = azuread_group.group.onpremises_domain_name
  description = "The on-premises FQDN, also called dnsDomainName, synchronized from the on-premises directory when Azure AD Connect is used"
}
output "onpremises_netbios_name" {
  value       = azuread_group.group.onpremises_netbios_name
  description = "The on-premises NetBIOS name, synchronized from the on-premises directory when Azure AD Connect is used"
}
output "onpremises_sam_account_name" {
  value       = azuread_group.group.onpremises_sam_account_name
  description = "The on-premises SAM account name, synchronized from the on-premises directory when Azure AD Connect is used"
}
output "onpremises_security_identifier" {
  value       = azuread_group.group.onpremises_security_identifier
  description = "The on-premises security identifier (SID), synchronized from the on-premises directory when Azure AD Connect is used"
}
output "onpremises_sync_enabled" {
  value       = azuread_group.group.onpremises_sync_enabled
  description = "Whether this group is synchronized from an on-premises directory (true), no longer synchronized (false), or has never been synchronized (null)"
}
output "preferred_language" {
  value       = azuread_group.group.preferred_language
  description = "The preferred language for a Microsoft 365 group, in ISO 639-1 notation"
}
output "proxy_addresses" {
  value       = azuread_group.group.proxy_addresses
  description = "Email addresses for the group that direct to the same group mailbox"
}
output "rbac_id" {
  value       = azuread_group.group.object_id
  description = "The object id used in the Role Assignemnt"
}
