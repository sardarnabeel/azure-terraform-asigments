variable "vnet_config" {
  description = "Map of Virtual Network configurations with nested subnets"
  type = map(object({
    vnet_name     = string
    address_space = list(string)
    subnets = map(object({
      subnet_name    = string
      vnet_name      = string #added testing
      address_prefix = string
      Outbound          = optional(bool, false)
      delegation        = optional(object({
      name    = string
      actions = list(string)
    }), null)
    }))
  }))
}


variable "rg" {

}