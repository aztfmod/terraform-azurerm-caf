data "azurecaf_name" "appiwt" {
  name          = var.name
  resource_type = "azurerm_application_insights_web_test"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azapi_resource" "appiwt" {
  type      = "Microsoft.Insights/webtests@2022-06-15"
  name      = data.azurecaf_name.appiwt.result
  tags      = local.tags
  parent_id = var.resource_group_id
  location  = var.location
  body = jsonencode({
    properties = {
      Kind               = "standard"
      Name               = var.name
      SyntheticMonitorId = data.azurecaf_name.appiwt.result
      Description        = try(var.settings.description, "")
      Enabled            = try(var.settings.enabled, true)
      Frequency          = try(var.settings.frequency, 300)
      Timeout            = try(var.settings.timeout, 30)
      RetryEnabled       = try(var.settings.retry_enabled, true)
      Locations          = [for location in var.settings.geo_locations : { Id = location }]

      Request = {
        RequestUrl             = var.settings.request_url
        Headers                = try(var.settings.request_headers, null)
        HttpVerb               = try(var.settings.http_verb, "GET")
        RequestBody            = try(var.settings.request_body, null)
        FollowRedirects        = try(var.settings.follow_redirects, null)
        ParseDependentRequests = try(var.settings.parse_dependent_requests, false)
      }
      ValidationRules = {
        ExpectedHttpStatusCode        = try(var.settings.expected_http_status_code, 200)
        ContentValidation             = try(var.settings.content_validation, null)
        SSLCheck                      = try(var.settings.ssl_check_enabled, false)
        SSLCertRemainingLifetimeCheck = try(var.settings.ssl_cert_remaining_lifetime_check, null)
      }
    }
  })
}
