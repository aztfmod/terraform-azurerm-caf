global_settings = {
  default_region = "region1"
  environment    = "test"
  regions = {
    region1 = "eastus"
    region2 = "centralus"
    region3 = "westeurope"
  }
}

resource_groups = {
  batch_region1 = {
    name = "batch"
  }
}

batch_accounts = {
  batch1 = {
    name               = "batch"
    resource_group_key = "batch_region1"
  }
}

batch_certificates = {
  certificate1 = {
    name                 = "batch"
    batch_account_key    = "batch1"
    certificate_filename = "compute/batch/batch_certificate/100-batch-certificate/certificate.cer"
    format               = "Cer"
    thumbprint           = "adab19ff1b7709157c3217829be5a645530ce693"
    thumbprint_algorithm = "SHA1"
  }
}
