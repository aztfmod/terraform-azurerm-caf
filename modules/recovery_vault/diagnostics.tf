
module diagnostics {
  source = "../diagnostics"

  resource_id       = local.asr_id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = try(var.settings.diagnostic_profiles, {})
}