resource "azurerm_lb_probe" "lb_probe" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = var.loadbalancer_id
  name                = var.settings.probe_name
  port                = var.settings.port
  protocol            = try(var.settings.protocol, null) #Possible values are Http, Https or Tcp
  request_path        = try(var.settings.request_path, null) #Required if protocol is set to Http or Https. Otherwise, it is not allowed.
  interval_in_seconds = try(var.settings.interval_in_seconds, null) #The default value is 15, the minimum value is 5.
  number_of_probes    = try(var.settings.number_of_probes, null) # The default value is 2.
}