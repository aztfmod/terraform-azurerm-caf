resource "random_string" "domain_zone_name" {
  length  = 16
  special = false
  upper   = false
}

locals {
  dns_domain_name = var.name == "" ? format("%s.com", random_string.domain_zone_name.result) : var.name
}

resource "azurerm_resource_group_template_deployment" "domain" {
  name                = local.dns_domain_name
  resource_group_name = var.resource_group_name
  lifecycle {
    ignore_changes = [
      template_content,
      name
    ]
  }
  template_content = templatefile(
    local.arm_filename,
    {
      "name" = local.dns_domain_name

      "consent" = {
        # https://docs.microsoft.com/en-us/rest/api/appservice/topleveldomains/listagreements#examples
        "agreementKeys" = [
          try(var.settings.consent.agreement_key1, "DNRA"),
          try(var.settings.consent.agreement_key2, "DNPA")
        ]
        "agreedAt" = timestamp()
        "agreedBy" = try(var.settings.consent.agreed_by, "100.5.150.200:52212")
      }

      "privacy"       = lookup(var.settings, "privacy", true)
      "autoRenew"     = lookup(var.settings, "auto_renew", false)
      "dnsType"       = lookup(var.settings, "dnsType", var.existingDnsType)
      "targetDnsType" = lookup(var.settings, "target_dnstype", var.targetDnsType)
      "dnsZoneId"     = try(var.settings.dns_zone.id, var.dns_zone_id)

      # Admin Contact
      "contactAdmin" = {
        "address1"     = lookup(var.settings.contacts.contactAdmin, "address1", "")
        "address2"     = lookup(var.settings.contacts.contactAdmin, "address2", "")
        "city"         = lookup(var.settings.contacts.contactAdmin, "city", "")
        "country"      = lookup(var.settings.contacts.contactAdmin, "country", "")
        "postalCode"   = lookup(var.settings.contacts.contactAdmin, "postal_code", "")
        "state"        = lookup(var.settings.contacts.contactAdmin, "state", "")
        "email"        = var.settings.contacts.contactAdmin.email,
        "fax"          = lookup(var.settings.contacts.contactAdmin, "fax", "")
        "jobTitle"     = lookup(var.settings.contacts.contactAdmin, "job_title", "")
        "nameFirst"    = var.settings.contacts.contactAdmin.name_first
        "nameLast"     = var.settings.contacts.contactAdmin.name_last
        "nameMiddle"   = lookup(var.settings.contacts.contactAdmin, "name_middle", "")
        "organization" = lookup(var.settings.contacts.contactAdmin, "organization", "")
        "phone"        = var.settings.contacts.contactAdmin.phone
      }

      # Billing Contact
      "contactBilling" = {
        "address1"     = try(var.settings.contacts.contactBilling.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.address1, "") : try(var.settings.contacts.contactBilling.address1, "")
        "address2"     = try(var.settings.contacts.contactBilling.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.address2, "") : try(var.settings.contacts.contactBilling.address2, "")
        "city"         = try(var.settings.contacts.contactBilling.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.city, "") : try(var.settings.contacts.contactBilling.city, "")
        "country"      = try(var.settings.contacts.contactBilling.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.country, "") : try(var.settings.contacts.contactBilling.country, "")
        "postalCode"   = try(var.settings.contacts.contactBilling.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.postal_code, "") : try(var.settings.contacts.contactBilling.postal_code, "")
        "state"        = try(var.settings.contacts.contactBilling.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.state, "") : try(var.settings.contacts.contactBilling.state, "")
        "email"        = try(var.settings.contacts.contactBilling.same_as_admin, false) ? var.settings.contacts.contactAdmin.email : try(var.settings.contacts.contactBilling.email, "")
        "fax"          = try(var.settings.contacts.contactBilling.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.fax, "") : try(var.settings.contacts.contactBilling.fax, "")
        "jobTitle"     = try(var.settings.contacts.contactBilling.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.job_title, "") : try(var.settings.contacts.contactBilling.job_title, "")
        "nameFirst"    = try(var.settings.contacts.contactBilling.same_as_admin, false) ? var.settings.contacts.contactAdmin.name_first : try(var.settings.contacts.contactBilling.name_first, "")
        "nameLast"     = try(var.settings.contacts.contactBilling.same_as_admin, false) ? var.settings.contacts.contactAdmin.name_last : try(var.settings.contacts.contactBilling.name_last, "")
        "nameMiddle"   = try(var.settings.contacts.contactBilling.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.name_middle, "") : try(var.settings.contacts.contactBilling.name_middle, "")
        "organization" = try(var.settings.contacts.contactBilling.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.organization, "") : try(var.settings.contacts.contactBilling.organization, "")
        "phone"        = try(var.settings.contacts.contactBilling.same_as_admin, false) ? var.settings.contacts.contactAdmin.phone : try(var.settings.contacts.contactBilling.phone, "")
      }

      # # Registrant Contact
      "contactRegistrant" = {
        "address1"     = try(var.settings.contacts.contactRegistrant.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.address1, "") : try(var.settings.contacts.contactRegistrant.address1, "")
        "address2"     = try(var.settings.contacts.contactRegistrant.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.address2, "") : try(var.settings.contacts.contactRegistrant.address2, "")
        "city"         = try(var.settings.contacts.contactRegistrant.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.city, "") : try(var.settings.contacts.contactRegistrant.city, "")
        "country"      = try(var.settings.contacts.contactRegistrant.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.country, "") : try(var.settings.contacts.contactRegistrant.country, "")
        "postalCode"   = try(var.settings.contacts.contactRegistrant.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.postal_code, "") : try(var.settings.contacts.contactRegistrant.postal_code, "")
        "state"        = try(var.settings.contacts.contactRegistrant.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.state, "") : try(var.settings.contacts.contactRegistrant.state, "")
        "email"        = try(var.settings.contacts.contactRegistrant.same_as_admin, false) ? var.settings.contacts.contactAdmin.email : try(var.settings.contacts.contactRegistrant.email, ""),
        "fax"          = try(var.settings.contacts.contactRegistrant.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.fax, "") : try(var.settings.contacts.contactRegistrant.fax, "")
        "jobTitle"     = try(var.settings.contacts.contactRegistrant.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.job_title, "") : try(var.settings.contacts.contactRegistrant.job_title, "")
        "nameFirst"    = try(var.settings.contacts.contactRegistrant.same_as_admin, false) ? var.settings.contacts.contactAdmin.name_first : try(var.settings.contacts.contactRegistrant.name_first, "")
        "nameLast"     = try(var.settings.contacts.contactRegistrant.same_as_admin, false) ? var.settings.contacts.contactAdmin.name_last : try(var.settings.contacts.contactRegistrant.name_last, "")
        "nameMiddle"   = try(var.settings.contacts.contactRegistrant.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.name_middle, "") : try(var.settings.contacts.contactRegistrant.name_middle, "")
        "organization" = try(var.settings.contacts.contactRegistrant.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.organization, "") : try(var.settings.contacts.contactRegistrant.organization, "")
        "phone"        = try(var.settings.contacts.contactRegistrant.same_as_admin, false) ? var.settings.contacts.contactAdmin.phone : try(var.settings.contacts.contactRegistrant.phone, "")
      }

      # Technical Contact
      "contactTechnical" = {
        "address1"     = try(var.settings.contacts.contactTechnical.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.address1, "") : try(var.settings.contacts.contactTechnical.address1, "")
        "address2"     = try(var.settings.contacts.contactTechnical.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.address2, "") : try(var.settings.contacts.contactTechnical.address2, "")
        "city"         = try(var.settings.contacts.contactTechnical.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.city, "") : try(var.settings.contacts.contactTechnical.city, "")
        "country"      = try(var.settings.contacts.contactTechnical.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.country, "") : try(var.settings.contacts.contactTechnical.country, "")
        "postalCode"   = try(var.settings.contacts.contactTechnical.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.postal_code, "") : try(var.settings.contacts.contactTechnical.postal_code, "")
        "state"        = try(var.settings.contacts.contactTechnical.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.state, "") : try(var.settings.contacts.contactTechnical.state, "")
        "email"        = try(var.settings.contacts.contactTechnical.same_as_admin, false) ? var.settings.contacts.contactAdmin.email : try(var.settings.contacts.contactTechnical.email, ""),
        "fax"          = try(var.settings.contacts.contactTechnical.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.fax, "") : try(var.settings.contacts.contactTechnical.fax, "")
        "jobTitle"     = try(var.settings.contacts.contactTechnical.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.job_title, "") : try(var.settings.contacts.contactTechnical.job_title, "")
        "nameFirst"    = try(var.settings.contacts.contactTechnical.same_as_admin, false) ? var.settings.contacts.contactAdmin.name_first : try(var.settings.contacts.contactTechnical.name_first, "")
        "nameLast"     = try(var.settings.contacts.contactTechnical.same_as_admin, false) ? var.settings.contacts.contactAdmin.name_last : try(var.settings.contacts.contactTechnical.name_last, "")
        "nameMiddle"   = try(var.settings.contacts.contactTechnical.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.name_middle, "") : try(var.settings.contacts.contactTechnical.name_middle, "")
        "organization" = try(var.settings.contacts.contactTechnical.same_as_admin, false) ? try(var.settings.contacts.contactAdmin.organization, "") : try(var.settings.contacts.contactTechnical.organization, "")
        "phone"        = try(var.settings.contacts.contactTechnical.same_as_admin, false) ? var.settings.contacts.contactAdmin.phone : try(var.settings.contacts.contactTechnical.phone, "")
      }

    }
  )


  deployment_mode = "Incremental"
}

resource "azurerm_management_lock" "lock_domain" {
  count      = try(var.settings.lock_resource, false) ? 1 : 0
  name       = "${local.dns_domain_name}-lock-domain"
  scope      = jsondecode(azurerm_resource_group_template_deployment.domain.output_content).id.value
  lock_level = "CanNotDelete"
  notes      = "Deleting a domain will make it unavailable to purchase for 60 days. Please remove the lock before deleting this domain."
}
