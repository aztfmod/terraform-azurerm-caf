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

  # Generate a list of topics to create
  topics_list = flatten(
    [for topicname in keys(lookup(var.settings, "topics", {})) :
      topicname
    ]
  )

  # Generate a list of topics to create shared access policies with reader right
  topics_reader = flatten(
    [for topicname, params in lookup(var.settings, "topics", {}) :
      topicname if lookup(params, "reader", false)
    ]
  )

  # Generate a list of topics to create shared access policies with sender right
  topics_sender = flatten(
    [for topicname, params in lookup(var.settings, "topics", {}) :
      topicname if lookup(params, "sender", false)
    ]
  )

  # Generate a list of topics to create shared access policies with manage right
  topics_manage = flatten(
    [for topicname, params in lookup(var.settings, "topics", {}) :
      topicname if lookup(params, "manage", false)
    ]
  )
}