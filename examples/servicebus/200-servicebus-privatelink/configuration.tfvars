global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
}


resource_groups = {
  rg1 = {
    name = "servicebus-rg"
  }
}

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
      subnet2 = {
        name                                           = "subnet2"
        cidr                                           = ["172.33.101.0/24"]
        service_endpoint                               = ["Microsoft.ServiceBus"]
        enforce_private_link_endpoint_network_policies = "true"
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
    name     = "jstestbusaztfmod"
    sku      = "Premium" # Basic | standard | Premium
    capacity = 1         # capacity only for Premium: 1,2,4,8,16 otherwise 0
    # zone_redundant = false # only true for Premium
    # tags = {} # optional
    namespace_auth_rules = {
      rule1 = {
        name   = "rule1"
        listen = true
        send   = true
        manage = false
      }
    }

    network_rule_sets = { # created in terraform but not reflected in azure?
      ruleset1 = {
        default_action = "Allow"
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

    private_endpoints = {
      hub_rg1-jumphost = {
        name               = "sb-test-private-link"
        resource_group_key = "rg1"
        vnet_key           = "vnet1"
        subnet_key         = "subnet2"
        private_service_connection = {
          name                 = "sb-private-link"
          is_manual_connection = false
          subresource_names    = ["namespace"]
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
        #   # queue_name = "" # full name of the queue
        #   # topic_name = "" # full name of the topic
        #   queue = { # key reference only works for remote landingzone
        #     # name = ""
        #     # lz_key = ""
        #     # key = ""
        #   }
        #   # topic = {
        #   #   # name = ""
        #   #   lz_key = ""
        #   #   key = ""
        #   # }
        # }

        # forward_dead_lettered_messages_to = {
        #   # queue_name = "" # full name of the queue
        #   # topic_name = "" # full name of the topic
        #   queue = { # key reference only works for remote landingzone
        #     # name = ""
        #     # lz_key = ""
        #     # key = ""
        #   }
        #   # topic = {
        #   #   # name = ""
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

    # lock_duration = "PT30S"
    # max_size_in_megabytes = 1024
    # requires_duplicate_detection = false
    # requires_session = false
    # default_message_ttl = "P14D"
    # dead_lettering_on_message_expiration = false
    # duplicate_detection_history_time_window = "PT10M"
    # max_delivery_count = 1
    # status = "Active" # Active, Creating, Deleting, Disabled, ReceiveDisabled, Renaming, SendDisabled, Unknown
    # enable_batched_operations = true
    # auto_delete_on_idle = "PT5M"
    # enable_partitioning = false
    # enable_express = false

    # forward_to = {
    #   # queue_name = "" # full name of the queue
    #   # topic_name = "" # full name of the topic
    #   queue = { # key reference only works for remote landingzone
    #     # name = ""
    #     # lz_key = ""
    #     # key = ""
    #   }
    #   # topic = {
    #   #   # name = ""
    #   #   lz_key = ""
    #   #   key = ""
    #   # }
    # }

    # forward_dead_lettered_messages_to = {
    #   # queue_name = "" # full name of the queue
    #   # topic_name = "" # full name of the topic
    #   queue = { # key reference only works for remote landingzone
    #     # name = ""
    #     # lz_key = ""
    #     # key = ""
    #   }
    #   # topic = {
    #   #   # name = ""
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
