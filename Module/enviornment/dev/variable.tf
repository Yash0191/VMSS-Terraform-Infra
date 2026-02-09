variable "rgs" {
  type = map(object({
    rgname   = string
    location = string
  }))
}

variable "stgs" {
  type = map(object({
    stgname                  = string
    rgname                   = string
    location                 = string
    account_tier             = string
    account_replication_type = string
  }))

}

variable "vnet" {
  type = map(object({
    rgname   = string
    location = string
    vnetname = string


  }))

}

variable "nic" {
  type = map(object({
    nicname                       = string
    location                      = string
    rgname                        = string
    ip_config_name                = string
    subnet_id                     = string
    private_ip_address_allocation = string

  }))
}

variable "sub" {
  type = map(object({
    subname          = string
    rgname           = string
    vnetname         = string
    address_prefixes = list(string)
  }))

}


variable "pip" {
  type = map(object({
    pipname           = string
    location          = string
    rgname            = string
    allocation_method = string

  }))

}

variable "lb" {
  type = map(object({
    location                       = string
    rgname                         = string
    lbname                         = string
    frontend_ip_configuration_name = string
    public_ip                      = string
  }))

}

variable "vmss" {
  type = map(object({
    vmss_name      = string
    location       = string
    rgname         = string
    size           = string
    admin_username = string
    admin_password = string
    subnet_id      = string
  }))
}

variable "bastion" {
  type = map(object({
    bastion_name          = string
    location              = string
    rgname                = string
    ip_configuration_name = string
    subnet_id             = string
    public_ip_address_id  = string
  }))
}

variable "lws" {
  type = map(object({
    lws_name = string
    location = string
    rgname   = string
  }))
}

variable "kv" {
  type = map(object({
    sku_name  = string
    location  = string
    rgname    = string
    kvname    = string
    tenant_id = string

  }))
}

variable "agw" {
  type = map(object({
    agwname              = string
    location             = string
    rgname               = string
    subnet_id            = string
    public_ip_address_id = string
  }))
}

