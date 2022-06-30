keyvault_certificates = {
  "demoapp1.cafdemo.com" = {

    keyvault_key = "certificates"

    # may only contain alphanumeric characters and dashes
    name = "demoapp1-cafdemo-com"

    subject            = "CN=demoapp1"
    validity_in_months = 12

    subject_alternative_names = {
      #  A list of alternative DNS names (FQDNs) identified by the Certificate.
      # Changing this forces a new resource to be created.
      dns_names = [
        "demoapp1.cafdemo.com"
      ]

      # A list of email addresses identified by this Certificate.
      # Changing this forces a new resource to be created.
      # emails = []

      # A list of User Principal Names identified by the Certificate.
      # Changing this forces a new resource to be created.
      # upns = []
    }

    tags = {
      type = "SelfSigned"
    }

    # Possible values include Self (for self-signed certificate),
    # or Unknown (for a certificate issuing authority like Let's Encrypt
    # and Azure direct supported ones).
    # Changing this forces a new resource to be created
    issuer_parameters = "Self"

    exportable = true

    # Possible values include 2048 and 4096.
    # Changing this forces a new resource to be created.
    key_size  = 4096
    key_type  = "RSA"
    reuse_key = true

    # The Type of action to be performed when the lifetime trigger is triggered.
    # Possible values include AutoRenew and EmailContacts.
    # Changing this forces a new resource to be created.
    action_type = "AutoRenew"

    # The number of days before the Certificate expires that the action
    # associated with this Trigger should run.
    # Changing this forces a new resource to be created.
    # Conflicts with lifetime_percentage
    days_before_expiry = 30


    # The percentage at which during the Certificates Lifetime the action
    # associated with this Trigger should run.
    # Changing this forces a new resource to be created.
    # Conflicts with days_before_expiry
    # lifetime_percentage = 90

    # The Content-Type of the Certificate, such as application/x-pkcs12 for a PFX
    # or application/x-pem-file for a PEM.
    # Changing this forces a new resource to be created.
    content_type = "application/x-pkcs12"

    # A list of uses associated with this Key.
    # Possible values include
    # cRLSign, dataEncipherment, decipherOnly,
    # digitalSignature, encipherOnly, keyAgreement, keyCertSign,
    # keyEncipherment and nonRepudiation
    # and are case-sensitive.
    # Changing this forces a new resource to be created
    key_usage = [
      "cRLSign",
      "dataEncipherment",
      "digitalSignature",
      "keyAgreement",
      "keyCertSign",
      "keyEncipherment",
    ]
  }
}