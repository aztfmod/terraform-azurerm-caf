This example tests the creation of a keyvault_certificate_requests using a domain_name_registration created in the same landing zone.

This example has the keyvault_certificate_requests[key].certificate_policy.x509_certificate_properties.domain_name_registration.lz_key commented out as this domain_name_registration is in the same landing zone. You can use that lz_key property to use a domain_name_registration that was created on another landing zone.
