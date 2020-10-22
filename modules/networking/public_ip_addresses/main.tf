locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(local.module_tag, var.tags, var.base_tags)
}