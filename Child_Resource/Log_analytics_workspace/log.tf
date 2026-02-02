resource "azurerm_log_analytics_workspace" "LWS" {
  name                = var.lws_name
  location            = var.location
  resource_group_name = var.rgname
  sku                 = "PerGB2018"
  retention_in_days   = 30
}




