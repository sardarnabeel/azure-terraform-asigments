#-------without subnet delegation---------#
# vnet_config = {
#   "vnet1" = {
#     vnet_name     = "vnet1"
#     address_space = ["10.0.0.0/16"]
#     subnets = {
#       "subnet1" = {
#         subnet_name    = "subnet1"
#         vnet_name = "vnet1" #added testing
#         address_prefix = "10.0.1.0/24"
#         Outbound       = true
#       },
#       "subnet2" = {
#         subnet_name    = "subnet2"
#         vnet_name = "vnet1" #added testing
#         address_prefix = "10.0.2.0/24"
#         Outbound       = false
#       }
#     }
#   }
# }

#---------subnet delegation---------#
vnet_config = {
  "vnet1" = {
    vnet_name     = "vnet1"
    address_space = ["10.0.0.0/16"]
    subnets = {
      "subnet1" = {
        subnet_name    = "private-subnet"
        vnet_name      = "vnet1"
        address_prefix = "10.0.1.0/24"
        Outbound       = false
        delegation = {
          name = "mysql-flexible-server-delegation-private-subnet"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action"
          ]
        }
      },
      "subnet2" = {
        subnet_name    = "public-subnet"
        vnet_name      = "vnet1"
        address_prefix = "10.0.2.0/24"
        Outbound       = true
        delegation     = null
      }
    }
  }
}

rg = {
  resource_group_name = "my-resource-group"
  location            = "East US"
}