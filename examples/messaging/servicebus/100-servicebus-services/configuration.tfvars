global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  rg1 = {
    name   = "servicebus-example"
    region = "region1"
  }
}

# servicebus_namespaces = {
#   sb_ns1 = {
#     name               = "sb_ns1"
#     resource_group_key = "sb_examples"
#     sku                = "Standard"
#     region             = "region1"
#     capacity           = 1    # Optional: capacity attribute can only be used with Premium sku. Possible values 1,2,4,8 or 16
#     zone_redundant     = false # Optional: zone_redundant attribute can only be used with Premium sku. Defaults to false
#     tags = {
#       "environment" = "Dev"
#     }
#   }
# }


vnets = {
  vnet1 = {
    resource_group_key = "rg1"
    vnet = {
      name          = "servicebus-vnet"
      address_space = ["172.33.0.0/16"]
    }
    subnets = {
      subnet1 = {
        name              = "subnet1"
        cidr              = ["172.33.100.0/24"]
        service_endpoints = ["Microsoft.ServiceBus"]
      }
    }
  }
}

servicebus_namespaces = {
  namespace1 = {
    resource_group = {
      # lz_key = ""
      key = "rg1"
    }
    name     = "sbexample"
    sku      = "premium" # basic | standard | premium
    capacity = 1         # capacity only for premium: 1,2,4,8,16 otherwise 0
    # zone_redundant = false # only true for premium
    # tags = {} # optional
    namespace_auth_rules = {
      rule1 = {
        name   = "rule1"
        listen = true
        send   = true
        manage = false
      }
    }

    network_rule_sets = {
      ruleset1 = {
        default_action = "Deny"
        ip_rules       = ["1.1.1.1"]

        network_rules = {
          subnet1 = {
            # lz_key = ""
            vnet_key                             = "vnet1"
            subnet_key                           = "subnet1"
            ignore_missing_vnet_service_endpoint = false
          }
        }
      }
    }

  }
}

servicebus_topics = {
  topic1 = {
    # resource_group = { # Default to follow the namespace resource group when not specified
    #   # lz_key = ""
    #   key = "rg1"
    # }
    servicebus_namespace = {
      # lz_key = ""
      key = "namespace1"
    }
    name = "topic1"

    # auto_delete_on_idle = "P0Y0M0DT0H5M0S"
    # default_message_ttl = "P0Y0M0DT0H5M0S"
    # duplicate_detection_history_time_window = "P0Y0M0DT0H5M0S"
    enable_batched_operations    = false
    enable_express               = false
    enable_partitioning          = false
    max_size_in_megabytes        = 1024
    requires_duplicate_detection = false
    support_ordering             = false

    topic_auth_rules = {
      rule1 = {
        name   = "authrule1"
        listen = true
        send   = false
        manage = false # requires both listen and send
      }
    }

    subscriptions = {
      sub1 = {
        name               = "subtest1"
        max_delivery_count = 1

        auto_delete_on_idle                       = "P14DT5M"
        default_message_ttl                       = "P14D"
        lock_duration                             = "PT30S"
        dead_lettering_on_message_expiration      = false
        dead_lettering_on_filter_evaluation_error = true
        enable_batched_operations                 = false
        requires_session                          = false
        status                                    = "Active" # ReceiveDisabled, Disabled, Active (default)

        # forward_to = {
        #   queue = { # lz_key, key reference only work for queues created in a different landingzone
        #     # name = "" # full queue name
        #     # lz_key = ""
        #     # key = ""
        #   }
        #   # topic = {
        #   #   # name = "" # full topic name or use reference key below
        #   #   lz_key = ""
        #   #   key = ""
        #   # }
        # }

        # forward_dead_lettered_messages_to = {
        #   queue = { # lz_key, key reference only work for queues created in a different landingzone
        #     # name = "" # full queue name
        #     # lz_key = ""
        #     # key = ""
        #   }
        #   # topic = {
        #   #   # name = "" # full topic name or use reference key below
        #   #   lz_key = ""
        #   #   key = ""
        #   # }
        # }

        subscription_rules = {

          correlation_filter_rules = {
            rule1 = {
              name = "testrule1"
              # action = "" # in sql syntax against BrokeredMessage
              correlation_filter = {
                correlation_id = "high"
                label          = "red"
                properties = {
                  custom1 = "value"
                }
              }
            }
          }

          sql_filter_rules = {
            rule1 = {
              name = "testrule2"
              # action = ""
              filter_type = "SqlFilter"
              sql_filter  = "x=1"
            }
          }

        }

      }
    }
  }
}

servicebus_queues = {
  queue1 = {
    name = "testqueue1"
    servicebus_namespace = {
      # lz_key = ""
      key = "namespace1"
    }
    # resource_group = { # default to namespace rg
    #   lz_key = ""
    #   key = ""
    # }

    max_delivery_count    = 10
    max_size_in_megabytes = 1024
    default_message_ttl   = "P0Y0M14DT0H0M0S" # ISO 8601 format

    # lock_duration = "PT30S"
    # requires_duplicate_detection = false
    # requires_session = false
    # dead_lettering_on_message_expiration = false
    # duplicate_detection_history_time_window = "PT10M"
    # status = "Active" # Active, Creating, Deleting, Disabled, ReceiveDisabled, Renaming, SendDisabled, Unknown
    # enable_batched_operations = true
    # auto_delete_on_idle = "PT5M"
    # enable_partitioning = false # must be true on premium
    # enable_express = false

    # forward_to = {
    #   queue = { # lz_key, key reference only work for queues created in a different landingzone
    #     # name = "" # full queue name
    #     # lz_key = ""
    #     # key = ""
    #   }
    #   # topic = {
    #   #   # name = "" # full topic name or use reference key below
    #   #   lz_key = ""
    #   #   key = ""
    #   # }
    # }

    # forward_dead_lettered_messages_to = {
    #   queue = { # lz_key, key reference only work for queues created in a different landingzone
    #     # name = "" # full queue name
    #     # lz_key = ""
    #     # key = ""
    #   }
    #   # topic = {
    #   #   # name = "" # full topic name or use reference key below
    #   #   lz_key = ""
    #   #   key = ""
    #   # }
    # }

    queue_auth_rules = {
      rule1 = {
        name   = "qauthrule1"
        listen = true
        send   = false
        manage = false

      }
    }
  }
}
