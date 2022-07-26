global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
}

provider_azurerm_features_keyvault = {
  // set to true to cleanup the CI
  purge_soft_delete_on_destroy = true
}

resource_groups = {
  kv_region1 = {
    name = "example-rg1"
  }
}

keyvaults = {
  vault = {
    name               = "vault"
    resource_group_key = "kv_region1"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}

dynamic_keyvault_certificates = {
  vault = {
    # Self Signed Certificate e.g. created with TLS or ACME Provider
    # dynamic_certificate_from_output = {
    #   secret_name   = "dynamic-certificate-from-output"
    #   output_key    = "self_signed_certs"
    #   resource_key  = "self_signed_cert"
    #   attribute_key = "certificate_bundle_pem"
    # }
    dynamic_certificate_plain = {
      secret_name   = "dynamic-certificate-plain"
      contents      = "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCyJGj8uykMCwRb\npLz5OXY2Ts/VijK+6HWfUe26BX13609ynZFQmxTDrdVTuEw+OW3plDQILLfPIceg\n3c7Bbr4VSMk8o5aai1RrVJzlJ2U/5iC+yuRM0HUycOQlM5+SbSt2cX/H+Rq9Nu34\nbAUtH3K84OrofgDPOowlF7kJm2/oVhddy5j9OCYJHRaRg+7GVeJqCht463db9A2Z\navykESoq/XjqGSFLJFF0WoFEJILDM1cvrebQ4Iz530IeCLqjF2978NpRF196M0J8\nbUY4I3m5976M8VO3UlVRNwq8deg5aUdym8yT6Og1i9DeVKFyZ8uVhrJdR5YCJ325\nljxDbAJrAgMBAAECggEAMZwYLMHGdZcf2JGxGsrY09jw4iwBY88C6qJ7TMG4pku+\nrVGaJVN63d+sOAtsGCwQIutl7hzd924V1QPQT2gSwYSqnhuElndUxCslIl/tP3VM\nCzYfjBDFgo2Ty5RrzPBgGTUUe9EwlB8W+IbEjkNixZzxblugyBUq8C2CF13VNWNF\nTRsW5IzbRzZBoQwU4hT95bF6Ldpzu5dE669xFkJhzqees3jZEK+poUetV1gxKuNE\nQnL7VOAwkhZyR4xqx6qVOhL4BQRzjIH53FRAEabZfaQTC2m0VSs2we8RahQS8Akc\nm6+iZBGqQaCIKT0PJHMn/FhUPLspdE7oVyYw8QNNKQKBgQDOVkHUSnh8XBGep0LW\nUmvkQCUoqs3fxJ2hwV31gb0dKx9FOSnj2DePqbshlUgA1n/rqWCNZ6xMk8w9hvt9\nIydYh7Mec+yxU61hIDOVdqLEKguQfyjFu73Ta3HD9J8Fok0fZaH5lLwy54u/V0VH\nfiJsgtS96UftnP/wftVeIitQDwKBgQDdBOVKyKlrQanYZmTdSULEhMSBtCvnte38\nX/3spFk9XN9gCsRzhzJ3BC7708IINuVIWY3G0haCQ430yDgkoR6o2Y9MIMS6D0YD\nDEWis9sjDBQP4C+1w5eYJEaVRYZxMo1plf+k6NC+vZIv1AyOA45KKpP8YJgf6NFA\nMchtQTdL5QKBgH9NdJv3vlJrs2tBItl8TJisgsCOcSpn8iFEXiYEf5spaceZtyCd\n29nFDHFx2tS5gn7xJ2LW3dT5Mv+a8jqIn9PdFUPqndPiHoxYA7tpUI7aqfvimFM2\nu61fEvelSx98vTxrxf1oKJz3gp7wxwuO5MoyBfONpBUT0kyc1COZzUM9AoGAZ6zi\nOeBCyJM2rtHpQnwZG8IDw6vWZIzMo/QLUrQNQGGOTqj+WgrzOyz1NR+yBtRpXTTU\n8oyeDmDN+CLrYxNJJH9ZXqaIYZbEiq15BMdFZf1Gc+P/vU2QkMeDbIX+eJ70ArFg\nB+VF9hNKvbDEauF0H4o1fM96zI0Tiv9POyC6ZZkCgYAWdR3qaRkS2nUSbOhkKk6f\n2+LdEc0ranHNDaod36Sl6+FnQmSRX/tA0wQAgfxhDDeXCFGygWQ/++SRkwkH56zv\n61oIBZiDvGybF+onut4IFySSCP3pbCa1xzU5STiX317NUEdPm43xNU/zyP70YbwU\nsMkwP/QqfiW2MXUq4hhE7A==\n-----END PRIVATE KEY-----\n-----BEGIN CERTIFICATE-----\nMIIDbzCCAlegAwIBAgIQPS0/fKNXVYJhYnXVosSL1DANBgkqhkiG9w0BAQsFADAW\nMRQwEgYDVQQDEwtleGFtcGxlLmNvbTAeFw0yMjA3MjYxNDU1NTNaFw0zMjA3MjMx\nNDU1NTNaMFcxCzAJBgNVBAYTAlVTMRwwGgYDVQQKExNFeGFtcGxlIFNlbGYgU2ln\nbmVkMRQwEgYDVQQLEwtleGFtcGxlLmNvbTEUMBIGA1UEAxMLZXhhbXBsZS5jb20w\nggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCyJGj8uykMCwRbpLz5OXY2\nTs/VijK+6HWfUe26BX13609ynZFQmxTDrdVTuEw+OW3plDQILLfPIceg3c7Bbr4V\nSMk8o5aai1RrVJzlJ2U/5iC+yuRM0HUycOQlM5+SbSt2cX/H+Rq9Nu34bAUtH3K8\n4OrofgDPOowlF7kJm2/oVhddy5j9OCYJHRaRg+7GVeJqCht463db9A2ZavykESoq\n/XjqGSFLJFF0WoFEJILDM1cvrebQ4Iz530IeCLqjF2978NpRF196M0J8bUY4I3m5\n976M8VO3UlVRNwq8deg5aUdym8yT6Og1i9DeVKFyZ8uVhrJdR5YCJ325ljxDbAJr\nAgMBAAGjeDB2MA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDAQYI\nKwYBBQUHAwIwDAYDVR0TAQH/BAIwADAfBgNVHSMEGDAWgBTAqaadgWb4aKsR2KeE\nfeCSA4AjfTAWBgNVHREEDzANggtleGFtcGxlLmNvbTANBgkqhkiG9w0BAQsFAAOC\nAQEAXRFEki5Smrd/jy8i9O0abjCIg3wCiBLZSEthMLgxHn6pP3x+LbjVw8gNoAP4\nT6wZNgaZF/JQtsOTCb+wKazw4oR/8Nqj1HZ7VOHDENrYWOhngJ9t0XuL/t9MTipW\ntdGmpOLU1DQyOUDYImhacNHULZxwxLWUSQxcnRIBQN7czfu61fpZtuaa2HSc2+T9\n61JxnaDDeZWsAt51zwn943xvWpEB0uteJBuHUcTmLFjUhiUxFlR3t4ub4l7OGZfZ\n1Pot8N03if5Cu7ietdaIG3an05fJbrEMuAiqDukcoqg6lUG9reWGBtJRPH0s0Dsq\nEW4S9O76xxTMlKj/SvXvXudUEA==\n-----END CERTIFICATE-----"
    }
  }
}
