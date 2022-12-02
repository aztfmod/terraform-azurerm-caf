output "user_principal_name" {
  value       = azuread_user.account.user_principal_name
  description = "The user principal name (UPN) of the user"
}
output "display_name" {
  value       = azuread_user.account.display_name
  description = "The name to display in the address book for the user"
}
output "account_enabled" {
  value       = azuread_user.account.account_enabled
  description = "Whether or not the account should be enabled"
}
output "age_group" {
  value       = azuread_user.account.age_group
  description = "The age group of the user"
}
output "business_phones" {
  value       = azuread_user.account.business_phones
  description = "The telephone numbers for the user. Only one number can be set for this property. Read-only for users synced with Azure AD Connect"
}
output "city" {
  value       = azuread_user.account.city
  description = "The city in which the user is located"
}
output "company_name" {
  value       = azuread_user.account.company_name
  description = "The company name which the user is associated. This property can be useful for describing the company that an external user comes from"
}
output "consent_provided_for_minor" {
  value       = azuread_user.account.consent_provided_for_minor
  description = "Whether consent has been obtained for minors"
}
output "cost_center" {
  value       = azuread_user.account.cost_center
  description = "The cost center associated with the user."
}
output "country" {
  value       = azuread_user.account.country
  description = "The country/region in which the user is located, e.g. `US` or `UK`"
}
output "department" {
  value       = azuread_user.account.department
  description = "The name for the department in which the user works"
}
output "division" {
  value       = azuread_user.account.division
  description = "The name of the division in which the user works."
}
output "employee_id" {
  value       = azuread_user.account.employee_id
  description = "The employee identifier assigned to the user by the organisation"
}
output "employee_type" {
  value       = azuread_user.account.employee_type
  description = "Captures enterprise worker type. For example, Employee, Contractor, Consultant, or Vendor."
}
output "force_password_change" {
  value       = azuread_user.account.force_password_change
  description = "Whether the user is forced to change the password during the next sign-in. Only takes effect when also changing the password"
}
output "given_name" {
  value       = azuread_user.account.given_name
  description = "The given name (first name) of the user"
}
output "fax_number" {
  value       = azuread_user.account.fax_number
  description = "The fax number of the user"
}
output "job_title" {
  value       = azuread_user.account.job_title
  description = "The user�s job title"
}
output "mail" {
  value       = azuread_user.account.mail
  description = "The SMTP address for the user. Cannot be unset."
}
output "mail_nickname" {
  value       = azuread_user.account.mail_nickname
  description = "The mail alias for the user. Defaults to the user name part of the user principal name (UPN)"
}
output "manager_id" {
  value       = azuread_user.account.manager_id
  description = "The object ID of the user's manager"
}
output "mobile_phone" {
  value       = azuread_user.account.mobile_phone
  description = "The primary cellular telephone number for the user"
}
output "office_location" {
  value       = azuread_user.account.office_location
  description = "The office location in the user's place of business"
}
output "onpremises_immutable_id" {
  value       = azuread_user.account.onpremises_immutable_id
  description = "The value used to associate an on-premise Active Directory user account with their Azure AD user object. This must be specified if you are using a federated domain for the user's `user_principal_name` property when creating a new user account"
}
output "other_mails" {
  value       = azuread_user.account.other_mails
  description = "Additional email addresses for the user"
}
output "disable_strong_password" {
  value       = azuread_user.account.disable_strong_password
  description = "Whether the user is allowed weaker passwords than the default policy to be specified."
}
output "disable_password_expiration" {
  value       = azuread_user.account.disable_password_expiration
  description = "Whether the users password is exempt from expiring"
}
output "postal_code" {
  value       = azuread_user.account.postal_code
  description = "The postal code for the user's postal address. The postal code is specific to the user's country/region. In the United States of America, this attribute contains the ZIP code"
}
output "preferred_language" {
  value       = azuread_user.account.preferred_language
  description = "The user's preferred language, in ISO 639-1 notation"
}
output "show_in_address_list" {
  value       = azuread_user.account.show_in_address_list
  description = "Whether or not the Outlook global address list should include this user"
}
output "state" {
  value       = azuread_user.account.state
  description = "The state or province in the user's address"
}
output "street_address" {
  value       = azuread_user.account.street_address
  description = "The street address of the user's place of business"
}
output "surname" {
  value       = azuread_user.account.surname
  description = "The user's surname (family name or last name)"
}
output "usage_location" {
  value       = azuread_user.account.usage_location
  description = "The usage location of the user. Required for users that will be assigned licenses due to legal requirement to check for availability of services in countries. The usage location is a two letter country code (ISO standard 3166). Examples include: `NO`, `JP`, and `GB`. Cannot be reset to null once set"
}
output "about_me" {
  value       = azuread_user.account.about_me
  description = "A freeform field for the user to describe themselves"
}
output "object_id" {
  value       = azuread_user.account.object_id
  description = "The object ID of the user"
}
output "creation_type" {
  value       = azuread_user.account.creation_type
  description = "Indicates whether the user account was created as a regular school or work account (`null`), an external account (`Invitation`), a local account for an Azure Active Directory B2C tenant (`LocalAccount`) or self-service sign-up using email verification (`EmailVerified`)"
}
output "external_user_state" {
  value       = azuread_user.account.external_user_state
  description = "For an external user invited to the tenant, this property represents the invited user's invitation status"
}
output "im_addresses" {
  value       = azuread_user.account.im_addresses
  description = "The instant message voice over IP (VOIP) session initiation protocol (SIP) addresses for the user"
}
output "onpremises_distinguished_name" {
  value       = azuread_user.account.onpremises_distinguished_name
  description = "The on-premise Active Directory distinguished name (DN) of the user"
}
output "onpremises_domain_name" {
  value       = azuread_user.account.onpremises_domain_name
  description = "The on-premise FQDN (i.e. dnsDomainName) of the user"
}
output "onpremises_sam_account_name" {
  value       = azuread_user.account.onpremises_sam_account_name
  description = "The on-premise SAM account name of the user"
}
output "onpremises_security_identifier" {
  value       = azuread_user.account.onpremises_security_identifier
  description = "The on-premise security identifier (SID) of the user"
}
output "onpremises_sync_enabled" {
  value       = azuread_user.account.onpremises_sync_enabled
  description = "Whether this user is synchronized from an on-premises directory (true), no longer synchronized (false), or has never been synchronized (null)"
}
output "onpremises_user_principal_name" {
  value       = azuread_user.account.onpremises_user_principal_name
  description = "The on-premise user principal name of the user"
}
output "proxy_addresses" {
  value       = azuread_user.account.proxy_addresses
  description = "Email addresses for the user that direct to the same mailbox"
}
output "user_type" {
  value       = azuread_user.account.user_type
  description = "The user type in the directory. Possible values are `Guest` or `Member`"
}

#legacy outputs
output "rbac_id" {
  value       = azuread_user.account.object_id
  description = "This attribute is used to set the role assignment"
}

output "id" {
  value = azuread_user.account.id
}