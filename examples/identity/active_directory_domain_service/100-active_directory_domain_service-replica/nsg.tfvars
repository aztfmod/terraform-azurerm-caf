network_security_group_definition = {
  aadds_re1 = {
    version            = 1
    resource_group_key = "rg"
    region             = "region1"
    name               = "nsg-aadds-re1"
    nsg = [
      {
        name                       = "Debugging for support."
        priority                   = "400"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "CorpNetSaw"
        destination_address_prefix = "*"
      },
      {
        name                       = "Powershell remoting."
        priority                   = "401"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "5986"
        source_address_prefix      = "AzureActiveDirectoryDomainServices"
        destination_address_prefix = "*"
      },
      {
        name                       = "Communication with the Azure AD Domain Services management service."
        priority                   = "400"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureActiveDirectoryDomainServices"
      },
      {
        name                       = "Monitoring of the virtual machines."
        priority                   = "401"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureMonitor"
      },
      {
        name                       = "Communication with Azure Storage."
        priority                   = "402"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "Storage"
      },
      {
        name                       = "Communication with Azure Active Directory."
        priority                   = "403"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureActiveDirectory"
      },
      {
        name                       = "Communication with Windows Update."
        priority                   = "404"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureUpdateDelivery"
      },
      {
        name                       = "Download of patches from Windows Update."
        priority                   = "405"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureFrontDoor.FirstParty"
      },
      {
        name                       = "Automated management of security patches."
        priority                   = "406"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "GuestAndHybridManagement"
      },
    ]
  }
  aadds_re2 = {
    version            = 1
    resource_group_key = "rg"
    region             = "region2"
    name               = "nsg-aadds-re2"
    nsg = [
      {
        name                       = "Debugging for support."
        priority                   = "400"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "CorpNetSaw"
        destination_address_prefix = "*"
      },
      {
        name                       = "Powershell remoting."
        priority                   = "401"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "5986"
        source_address_prefix      = "AzureActiveDirectoryDomainServices"
        destination_address_prefix = "*"
      },
      {
        name                       = "Communication with the Azure AD Domain Services management service."
        priority                   = "400"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureActiveDirectoryDomainServices"
      },
      {
        name                       = "Monitoring of the virtual machines."
        priority                   = "401"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureMonitor"
      },
      {
        name                       = "Communication with Azure Storage."
        priority                   = "402"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "Storage"
      },
      {
        name                       = "Communication with Azure Active Directory."
        priority                   = "403"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureActiveDirectory"
      },
      {
        name                       = "Communication with Windows Update."
        priority                   = "404"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureUpdateDelivery"
      },
      {
        name                       = "Download of patches from Windows Update."
        priority                   = "405"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureFrontDoor.FirstParty"
      },
      {
        name                       = "Automated management of security patches."
        priority                   = "406"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "GuestAndHybridManagement"
      },
    ]
  }
}