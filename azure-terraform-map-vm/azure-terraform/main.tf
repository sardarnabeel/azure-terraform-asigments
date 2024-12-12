module "resource_group" {
  source = "./modules/resource_group"
  rg-var = var.rg-var
}
module "vm" {
  source              = "./modules/vm"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  vm_config           = var.vm_config
  nsg_ids             = module.nsg.nsg_ids
  subnet_ids          = module.vnet.subnet_ids #its new for testing
}

module "nsg" {
  source              = "./modules/mysql-nsg"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  nsg_config          = var.nsg_config
  # nsg_rules           = var.nsg_rules #this will with single port range
}


module "vnet" {
  source              = "./modules/vnet"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  vnet_config         = var.vnet_config
  subnet_config       = var.subnet_config
}

module "load_balancer" {
  source              = "./modules/load_balancer"
  lb                  = var.lb_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  nic_ids             = module.vm.nic_ids["vm1"]

}



module "nat_gateway" {
  source              = "./modules/nat-gateway"
  nat-var             = var.nat-var
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  subnet_id           = lookup(module.vnet.subnet_ids, "private-subnet", null) # Direct lookup for private subnet ID
}
