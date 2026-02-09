module "calling_rg" {
  source   = "../../../Child_Resource/azurerm_resource_group"
  for_each = var.rgs
  rgname   = each.value.rgname
  location = each.value.location
}

module "calling_stg" {
  source                   = "../../../Child_Resource/storage_account"
  depends_on               = [module.calling_rg]
  for_each                 = var.stgs
  stgname                  = each.value.stgname
  location                 = each.value.location
  rgname                   = each.value.rgname
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type


}

module "vnet" {
  source     = "../../../Child_Resource/azure_vnet"
  depends_on = [module.calling_rg]
  for_each   = var.vnet
  vnetname   = each.value.vnetname
  location   = each.value.location
  rgname     = each.value.rgname
}


module "calling_subnet" {
  source           = "../../../Child_Resource/azurerm_subnet"
  depends_on       = [module.vnet]
  for_each         = var.sub
  subname          = each.value.subname
  rgname           = each.value.rgname
  vnetname         = each.value.vnetname
  address_prefixes = each.value.address_prefixes
}


module "nic" {
  source     = "../../../Child_Resource/azurerm_nic"
  depends_on = [module.calling_subnet]
  for_each   = var.nic

  nicname                       = each.value.nicname
  location                      = each.value.location
  rgname                        = each.value.rgname
  ip_config_name                = each.value.ip_config_name
  private_ip_address_allocation = each.value.private_ip_address_allocation

  subnet_id = module.calling_subnet[each.value.subnet_id].subnet_id

}

module "calling_pip" {
  source            = "../../../Child_Resource/azurerm_public_ip"
  depends_on        = [module.calling_rg]
  for_each          = var.pip
  pipname           = each.value.pipname
  location          = each.value.location
  rgname            = each.value.rgname
  allocation_method = each.value.allocation_method
}

module "calling_lb" {
  source     = "../../../Child_Resource/Load_balancer"
  depends_on = [module.calling_rg, module.calling_pip]
  for_each   = var.lb

  rgname                         = each.value.rgname
  location                       = each.value.location
  lbname                         = each.value.lbname
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name

  public_ip = module.calling_pip[each.value.public_ip].pip_id

}

module "calling_vmss" {
  source     = "../../../Child_Resource/vmms"
  depends_on = [module.calling_subnet]

  for_each = var.vmss

  vmss_name      = each.value.vmss_name
  rgname         = each.value.rgname
  location       = each.value.location
  size           = each.value.size
  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  subnet_id = module.calling_subnet[each.value.subnet_id].subnet_id
}

module "calling_bastion" {
  source     = "../../../Child_Resource/bastion"
  depends_on = [module.calling_subnet, module.calling_pip]

  for_each              = var.bastion
  bastion_name          = each.value.bastion_name
  location              = each.value.location
  rgname                = each.value.rgname
  ip_configuration_name = each.value.ip_configuration_name
  subnet_id             = module.calling_subnet[each.value.subnet_id].subnet_id
  public_ip_address_id  = module.calling_pip[each.value.public_ip_address_id].pip_id

}

module "calling_lws" {
  source     = "../../../Child_Resource/Log_analytics_workspace"
  depends_on = [module.calling_rg]

  for_each = var.lws

  lws_name = each.value.lws_name
  location = each.value.location
  rgname   = each.value.rgname

}

module "kv" {
  source = "../../../Child_Resource/Key_vault"

  for_each = var.kv

  rgname = each.value.rgname
  location = each.value.location
  sku_name = each.value.sku_name
  kvname  = each.value.kvname
  tenant_id = each.value.tenant_id

  
}

module "calling_agw" {
  source     = "../../../Child_Resource/application_gateway"
  depends_on = [module.calling_subnet]

  for_each = var.agw

  agwname              = each.value.agwname
  location             = each.value.location
  rgname               = each.value.rgname
  subnet_id            = module.calling_subnet[each.value.subnet_id].subnet_id
  public_ip_address_id = module.calling_pip[each.value.public_ip_address_id].pip_id


}
