module "eventgrid_domain_topics" {
  source   = "../eventgrid_domain_topic"
  for_each = var.eventgrid_domain_topics

  resource_group_name = var.resource_group_name
  name                = each.value.name
  domain_name         = azurerm_eventgrid_domain.egd.name
  global_settings     = var.global_settings
  client_config       = var.client_config

}

output "eventgrid_domain_topics" {
  value = module.eventgrid_domain_topics

}