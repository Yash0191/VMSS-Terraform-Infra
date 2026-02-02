resource "azurerm_subnet" "sub" {
  name                 = var.subname
  resource_group_name  = var.rgname
  virtual_network_name = var.vnetname
  address_prefixes     = var.address_prefixes

}

