terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }

  # Generate a list of queues to create
  queues_list = flatten(
    [for queuename in keys(lookup(var.settings, "queues", {})) :
      queuename
    ]
  )

  # Generate a list of queues to create shared access policies with reader right
  queues_reader = flatten(
    [for queuename, params in lookup(var.settings, "queues", {}) :
      queuename if lookup(params, "reader", false)
    ]
  )

  # Generate a list of queues to create shared access policies with sender right
  queues_sender = flatten(
    [for queuename, params in lookup(var.settings, "queues", {}) :
      queuename if lookup(params, "sender", false)
    ]
  )

  # Generate a list of queues to create shared access policies with manage right
  queues_manage = flatten(
    [for queuename, params in lookup(var.settings, "queues", {}) :
      queuename if lookup(params, "manage", false)
    ]
  )
}