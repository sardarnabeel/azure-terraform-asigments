resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnet_config
  name                = each.value.vnet_name
  address_space       = each.value.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}


resource "azurerm_subnet" "subnet" {
  for_each             = var.subnet_config
  name                 = each.value.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet[each.value.vnet_key].name
  address_prefixes     = [each.value.address_prefix]
  default_outbound_access_enabled = each.value.Outbound
  private_link_service_network_policies_enabled = false
  private_endpoint_network_policies = "Disabled"

}