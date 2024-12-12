resource "azurerm_network_interface" "vm_nic" {
  for_each            = var.vm_config
  name                = "${each.value.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_ids[each.value.subnet_name] 
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  for_each                    = var.vm_config
  network_interface_id        = azurerm_network_interface.vm_nic[each.key].id
  network_security_group_id   = var.nsg_ids[each.value.nsg_name]
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = var.vm_config
  name                = each.value.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = each.value.vm_size
  admin_username      = each.value.admin_username
  network_interface_ids = [azurerm_network_interface.vm_nic[each.key].id]

  admin_ssh_key {
    username   = each.value.admin_username
    # public_key = var.ssh_public_key
    public_key = file(each.value.ssh_public_key)
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = each.value.image_publisher
    offer     = each.value.image_offer
    sku       = each.value.image_sku
    version   = "latest"
  }

  # custom_data = base64encode(each.value.user_data)
  custom_data = base64encode(templatefile(
  "${path.module}/${each.key == "vm1" ? "wordpress-userdata.sh" : "mysql-userdata.sh"}", 
  {
    db_ip = each.key == "vm1" ? azurerm_network_interface.vm_nic["vm2"].ip_configuration[0].private_ip_address : ""  # Pass db_ip to WordPress VM (vm1)
  }
))


}
