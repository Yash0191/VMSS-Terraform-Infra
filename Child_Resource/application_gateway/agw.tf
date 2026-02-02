resource "azurerm_application_gateway" "AGW" {
  name                = var.agwname
  resource_group_name = var.rgname
  location            = var.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "frontend_port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend_ip_confi"
    public_ip_address_id = var.public_ip_address_id
  }

  backend_address_pool {
    name = "backendpool"
  }

  backend_http_settings {
    name                  =  "backend_http_settings"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "http_listener"
    frontend_ip_configuration_name = "frontend_ip_configuration_name"
    frontend_port_name             = "frontend_port_name"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "request_routing_rule_name"
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = "listener_name"
    backend_address_pool_name  = "backend_address_pool_name"
    backend_http_settings_name = "http_setting_name"
  }
}