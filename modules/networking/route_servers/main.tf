locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.global_settings.tags, local.module_tag, var.tags, try(var.route_server.tags, null))
}