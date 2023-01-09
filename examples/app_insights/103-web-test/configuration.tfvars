
global_settings = {
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  rg1 = {
    name   = "examples-app-insights"
    region = "region1"
  }
}

azurerm_application_insights = {
  webapp = {
    name               = "tf-test-appinsights-web"
    resource_group_key = "rg1"
    application_type   = "web"
  }
}

azurerm_application_insights_web_test = {
  web_test = {
    name               = "example-web-test"
    resource_group_key = "rg1"
    application_insights = {
      key = "webapp"
    }
    kind          = "ping"
    frequency     = 300
    timeout       = 60
    enabled       = true
    geo_locations = ["us-tx-sn1-azr", "us-il-ch1-azr"]
    retry_enabled = true
    description   = "A sample Web test"

    configuration = <<XML
<WebTest Name="WebTest1" Id="ABD48585-0831-40CB-9069-682EA6BB3583" Enabled="True" CssProjectStructure="" CssIteration="" Timeout="0" WorkItemIds="" xmlns="http://microsoft.com/schemas/VisualStudio/TeamTest/2010" Description="" CredentialUserName="" CredentialPassword="" PreAuthenticate="True" Proxy="default" StopOnError="False" RecordedResultFile="" ResultsLocale="">
  <Items>
    <Request Method="GET" Guid="a5f10126-e4cd-570d-961c-cea43999a200" Version="1.1" Url="https://microsoft.com" ThinkTime="0" Timeout="300" ParseDependentRequests="True" FollowRedirects="True" RecordResult="True" Cache="False" ResponseTimeGoal="0" Encoding="utf-8" ExpectedHttpStatusCode="200" ExpectedResponseUrl="" ReportingName="" IgnoreHttpStatusCode="False" />
  </Items>
</WebTest>
XML
  }
}

azurerm_application_insights_standard_web_test = {
  web_test = {
    name               = "example-standard-web-test"
    resource_group_key = "rg1"
    application_insights = {
      key = "webapp"
    }
    frequency                         = 300
    timeout                           = 60
    enabled                           = true
    geo_locations                     = ["us-tx-sn1-azr", "us-il-ch1-azr"]
    retry_enabled                     = true
    description                       = "A sample standard Web test"
    request_url                       = "https://microsoft.com"
    ssl_check_enabled                 = true
    ssl_cert_remaining_lifetime_check = 30
  }
}
