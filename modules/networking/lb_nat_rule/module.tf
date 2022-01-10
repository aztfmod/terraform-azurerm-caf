

resource "azurecaf_name" "lb" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_lb_nat_rule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_lb_nat_rule" "lb" {



  name = azurecaf_name.lb.result





  resource_group_name = var.resource_group_name





  loadbalancer_id = var.settings.loadbalancer_id





  frontend_ip_configuration_name = var.settings.frontend_ip_configuration_name





  protocol = var.settings.protocol





  frontend_port = var.settings.frontend_port





  backend_port = var.settings.backend_port





  idle_timeout_in_minutes = try(var.settings.idle_timeout_in_minutes, null)





  enable_floating_ip = try(var.settings.enable_floating_ip, null)





  enable_tcp_reset = try(var.settings.enable_tcp_reset, null)



}