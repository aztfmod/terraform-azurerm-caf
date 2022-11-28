global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  random_length = 5
}

resource_groups = {
  test = {
    name = "test"
  }
}

consumption_budgets = {
  test_budget = {
    subscription = {
      # id     = "<subscription_id>"
      # lz_key = ""
      # key    = ""
    }
    name       = "example"
    amount     = 1000
    time_grain = "Monthly"
    time_period = {
      # uncomment to customize start_date
      # start_date = "2022-06-01T00:00:00Z"
    }
    notifications = {
      default = {
        enabled   = true
        threshold = 95.0
        operator  = "EqualTo"
        contact_emails = [
          "foo@example.com",
          "bar@example.com",
        ]
      }
      contact_email = {
        enabled   = true
        threshold = 90.0
        operator  = "EqualTo"
        contact_emails = [
          "foo@example.com",
          "bar@example.com",
        ]
      }
      contact_role = {
        enabled   = true
        threshold = 80.0
        operator  = "EqualTo"
        contact_roles = [
          "Owner",
        ]
      }
    }
    filter = {
      dimensions = {
        explicit_name = {
          name     = "ResourceGroupName"
          operator = "In"
          values = [
            "example",
          ]
        },
        resource_key = {
          # lz_key = "examples"
          name         = "resource_key"
          resource_key = "resource_groups"
          values = [
            "test",
          ]
        }
      }
      tags = {
        tag_example_default_operator = {
          name   = "level",
          values = ["100"]
        },
        tag_example_explicit_operator = {
          name     = "mode",
          operator = "In"
          values   = ["test"]
        }
      }
      not = {
        # dimension and tag block conflicts
        # dimension = {
        #   # not block supports only one dimension block
        #   # explicit_name = {
        #   #   name     = "ResourceGroupName"
        #   #   operator = "In"
        #   #   values = [
        #   #     "example",
        #   #   ]
        #   # },
        #   resource_key = {
        #     # lz_key = "examples"
        #     name         = "resource_key"
        #     resource_key = "resource_groups"
        #     values = [
        #       "test",
        #     ]
        #   }
        # }
        tag = {
          name   = "name"
          values = ["not-tag"]
        }
      }
    }
  }
}