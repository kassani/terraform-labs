resource "azurerm_resource_group" "nsgs" {
   name         = "devops-terraform"
   location     = var.loc
   tags         = var.tags
}

resource "azurerm_network_security_group" "resource_group_default" {
   name = "DevOpsResourceGroupDefault"
   resource_group_name  = azurerm_resource_group.nsgs.name
   location             = azurerm_resource_group.nsgs.location
   tags                 = azurerm_resource_group.nsgs.tags
}

resource "azurerm_network_security_rule" "AllowSSH" {
    name = "AllowSSH"
    resource_group_name         = azurerm_resource_group.nsgs.name
    network_security_group_name = azurerm_network_security_group.resource_group_default.name

    priority                    = 1010
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    destination_port_range      = 22
    destination_address_prefix  = "*"
    source_port_range           = "*"
    source_address_prefix       = "*"
}

resource "azurerm_network_security_rule" "AllowHTTP" {
    name = "AllowHTTP"
    resource_group_name         = azurerm_resource_group.nsgs.name
    network_security_group_name = azurerm_network_security_group.resource_group_default.name

    priority                    = 1020
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    destination_port_range      = 80
    destination_address_prefix  = "*"
    source_port_range           = "*"
    source_address_prefix       = "*"
}


resource "azurerm_network_security_rule" "AllowHTTPS" {
    name = "AllowHTTPS"
    resource_group_name         = azurerm_resource_group.nsgs.name
    network_security_group_name = azurerm_network_security_group.resource_group_default.name

    priority                    = 1021
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    destination_port_range      = 443
    destination_address_prefix  = "*"
    source_port_range           = "*"
    source_address_prefix       = "*"
}

resource "azurerm_network_security_rule" "AllowSQLServer" {
    name = "AllowSQLServer"
    resource_group_name         = azurerm_resource_group.nsgs.name
    network_security_group_name = azurerm_network_security_group.resource_group_default.name

    priority                    = 1030
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    destination_port_range      = 1443
    destination_address_prefix  = "*"
    source_port_range           = "*"
    source_address_prefix       = "*"
}

resource "azurerm_network_security_group" "nic_ubuntu" {
   name = "NIC_Ubuntu"
   resource_group_name  = azurerm_resource_group.nsgs.name
   location             = azurerm_resource_group.nsgs.location
   tags                 = azurerm_resource_group.nsgs.tags

    security_rule {
        name                       = "SSH"
        priority                   = 106
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = 22
        source_address_prefix      = "*"
        destination_address_prefix = "*"
  }
}
resource "azurerm_network_security_group" "nic_windows" {
   name = "NIC_Windows"
   resource_group_name  = azurerm_resource_group.nsgs.name
   location             = azurerm_resource_group.nsgs.location
   tags                 = azurerm_resource_group.nsgs.tags

    security_rule {
        name                       = "AllowRDP"
        priority                   = 111
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = 3389
        source_address_prefix      = "*"
        destination_address_prefix = "*"
  }
}
