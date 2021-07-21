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
    }
    filter = {
      dimensions = {
        resource_key = {
          # lz_key = "examples"
          name         = "resource_key"
          resource_key = "virtual_machines"
          values = [
            "example_vm1",
          ]
        }
      }
    }
  }
}