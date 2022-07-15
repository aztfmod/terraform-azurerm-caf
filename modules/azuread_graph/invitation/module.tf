
resource "azuread_invitation" "inv" {
  redirect_url       = var.settings.redirect_url
  user_email_address = var.settings.user_email_address
  user_display_name  = try(var.settings.user_display_name, null)
  dynamic "message" {
    for_each = try(var.settings.message, null) != null ? [var.settings.message] : []
    content {
      additional_recipients = try(message.value.additional_recipients, null)
      body                  = try(message.value.body, null)
      language              = try(message.value.language, null)
    }
  }
  user_type = try(var.settings.user_type, null)
}
