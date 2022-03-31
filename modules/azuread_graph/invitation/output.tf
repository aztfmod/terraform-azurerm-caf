output "redirect_url" {
  value = azuread_invitation.inv.redirect_url
  description = "The URL that the user should be redirected to once the invitation is redeemed"
}
output "user_email_address" {
  value = azuread_invitation.inv.user_email_address
  description = "The email address of the user being invited"
}
output "user_display_name" {
  value = azuread_invitation.inv.user_display_name
  description = "The display name of the user being invited"
}
output "message" {
  value = azuread_invitation.inv.message
  description = "Customize the message sent to the invited user"
}
output "user_type" {
  value = azuread_invitation.inv.user_type
  description = "The user type of the user being invited"
}
output "redeem_url" {
  value = azuread_invitation.inv.redeem_url
  description = "The URL the user can use to redeem their invitation"
}
output "user_id" {
  value = azuread_invitation.inv.user_id
  description = "Object ID of the invited user"
}
