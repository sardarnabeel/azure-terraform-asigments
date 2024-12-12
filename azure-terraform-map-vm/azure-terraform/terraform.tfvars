rg-var = {
  resource_group_name = "nabeel-rg"
  location            = "East US"
}

vm_config = {
  "vm1" = {
    vm_name        = "vm1"
    vm_size        = "Standard_B1s"
    admin_username = "azureuser"
    # ssh_public_key  = "ssh-rsa AAAAB3NzaC1yc2E..."
    image_publisher = "Canonical"
    image_offer     = "UbuntuServer"
    image_sku       = "18.04-LTS"
    # user_data       = "/home/nabeel/azure-terraform-map/azure-terraform/modules/vm/mysql-userdata.sh"
    nsg_name        = "nsg1"
    subnet_name     =   "public-subnet"
    ssh_public_key  = "/home/nabeel/.ssh/id_rsa.pub"

  }
  "vm2" = {
    vm_name        = "vm2"
    vm_size        = "Standard_B1s"
    admin_username = "azureuser"
    # ssh_public_key  = "ssh-rsa BBBB12das..."
    image_publisher = "Canonical"
    image_offer     = "UbuntuServer"
    image_sku       = "18.04-LTS"
    # user_data       = "/home/nabeel/azure-terraform-map/azure-terraform/modules/vm/mysql-userdata.sh"

    nsg_name        = "nsg2"
    subnet_name     =   "private-subnet"
    ssh_public_key  = "/home/nabeel/.ssh/id_rsa.pub"

  }
}







#create single rule OR create multuple rule resource using this
# NSG Configuration
nsg_config = {
  "nsg1" = {}
  "nsg2" = {}
}


#these nsg rules work with map of object and string only with single port rule
# nsg_rules = {
#   "nsg1" = {
#     name                       = "AllowSSH"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#     destination_port_range     = "22"
#     source_port_range          = "*" # Allow all source ports
#   }
#   "nsg2" = {
#     name                       = "AllowHTTP"
#     priority                   = 101
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#     destination_port_range     = "3306"
#     source_port_range          = "*" # Allow all source ports
#   }
# }



vnet_config = {
  "vnet1" = {
    vnet_name     = "my-vnet1"
    address_space = ["10.0.0.0/16"]
  }
  # "vnet2" = {
  #   vnet_name     = "my-vnet2"
  #   address_space = ["10.1.0.0/16"]
  # }
}

subnet_config = {
  "subnet1" = {
    subnet_name    = "public-subnet"
    vnet_key       = "vnet1"
    address_prefix = "10.0.1.0/24"
    Outbound       = true
  }
  "subnet2" = {
    subnet_name    = "private-subnet"
    vnet_key       = "vnet1"
    address_prefix = "10.0.2.0/24"
    Outbound       = false
  }
  # "subnet3" = {
  #   subnet_name    = "public-subnet2"
  #   vnet_key       = "vnet2"
  #   address_prefix = "10.1.1.0/24"
  #   Outbound     = false
  # }
}


lb_name = {
  lb_name = "example-nat-gateway"

}

nat-var = {
  nat_gateway_name = "example-nat-gateway"
}