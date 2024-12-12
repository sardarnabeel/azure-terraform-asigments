module "resource-group" {
  source = "./modules/resource_group"
  rg-var = var.rg
}

module "vnet_and_subnets" {
  for_each = var.vnet_config

  source = "./modules/vnet"
  # vnet_name           = each.value.vnet_name
  # address_space       = each.value.address_space

  vnet_test           = var.vnet_config
  location            = module.resource-group.location
  resource_group_name = module.resource-group.resource_group_name
  subnets             = each.value.subnets

}


















