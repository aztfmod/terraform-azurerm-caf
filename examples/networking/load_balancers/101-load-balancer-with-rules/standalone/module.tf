module "caf" {
  source          = "../../../../../"
  global_settings = var.global_settings
  resource_groups = var.resource_groups
  tags            = var.tags
  networking = {
    vnets               = var.vnets
    public_ip_addresses = var.public_ip_addresses
    load_balancers      = var.load_balancers
    load_balancer_rules = var.load_balancer_rules
    load_balancer_probe = var.load_balancer_probe
  }
}

