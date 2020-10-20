resource "azurerm_resource_group" "corenetwork" {
   name         = "devops-terraform-corenetwork"
   location     = var.loc
   tags         = var.tags
}

resource "azurerm_public_ip" "vpnGateWayPubicIP" {
  name                    = "Devops-terra-vpngatewaypublicip"
  location                = azurerm_resource_group.corenetwork.location
  resource_group_name     = azurerm_resource_group.corenetwork.name
  allocation_method       = "Dynamic"
}
/* Create  virtual network */
resource "azurerm_virtual_network" "corenetwork" {
   name                 = "devops-terraform-VirtualNetwork"
   location             = azurerm_resource_group.corenetwork.location
   resource_group_name  = azurerm_resource_group.corenetwork.name
   tags                 = azurerm_resource_group.corenetwork.tags

   address_space        = [ "10.0.0.0/16" ]
   dns_servers          = [ "1.1.1.1", "1.0.0.1" ]
}

/* Creating 3 Subnets */
resource "azurerm_subnet" "GatewaySubnet" {
   name                 = "devops-terraform-GatewaySubnet"
   resource_group_name  = azurerm_resource_group.corenetwork.name
   virtual_network_name = azurerm_virtual_network.corenetwork.name

   address_prefixes       = "10.0.0.0/24"
}

resource "azurerm_subnet" "training" {
   name                 = "devops-terraform-training"
   resource_group_name  = azurerm_resource_group.corenetwork.name
   virtual_network_name = azurerm_virtual_network.corenetwork.name

   address_prefixes       = "10.0.1.0/24"
}

resource "azurerm_subnet" "dev" {
   name                 = "devops-terraform-dev"
   resource_group_name  = azurerm_resource_group.corenetwork.name
   virtual_network_name = azurerm_virtual_network.corenetwork.name

   address_prefixes       = "10.0.2.0/24"
}