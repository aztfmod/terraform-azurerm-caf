output "id" {
  value       = azurerm_logic_app_trigger_http_request.laachr.id
  description = "The ID of the HTTP Request Trigger within the Logic App Workflow"
}
# output "callback_url" {
#   value       = azurerm_logic_app_trigger_http_request.laachr.callback_url
#   description = "The URL for the workflow trigger"
# }
