
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}


resource_groups = {
  automation = {
    name = "automation"
  }
}

automations = {
  auto1 = {
    name               = "automation"
    sku                = "basic"
    resource_group_key = "automation"
  }
}

automation_runbooks = {
  book_01 = {
    name                   = "test-001"
    resource_group_key     = "automation"
    automation_account_key = "auto1"
    runbook_type           = "PowerShell"
    log_progress           = true
    log_verbose            = false
    description            = "Script content provided via content attribute"

    # Custom timeouts defined
    timeouts = {
      #create = 60
      update = "55m"
      read   = "55m"
      delete = "55m"
    }
    content = <<EOT
    [CmdletBinding()]
    Write-Output "Hello World"
    EOT
  }
  book_02 = {
    name                   = "test-book-02"
    resource_group_key     = "automation"
    automation_account_key = "auto1"
    runbook_type           = "PowerShell"

    description = "Read script content from file"

    script_file = "./scripts/test.ps1"
  }
}
