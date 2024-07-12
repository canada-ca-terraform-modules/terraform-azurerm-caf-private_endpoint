variable "tags" {
  description = "Tags to be applied to the private endpoint"
  type = map(string)
  default = {}
}

variable "name" {
  description = "(Required) Name of the private endpoint"
  type = string
}

variable "resource_groups" {
  description = "(Required) Resource group object of private endpoint"
  type = any
}

variable "location" {
  description = "Azure location where the private endpoint will be located"
  type = any
  default = "canadacentral"
}

variable "subnets" {
  description = "(Required) Map of subnets"
  type = any
}

variable "private_connection_resource_id" {
  description = "(Required) The ID of the resource the private endpoint will be connected to"
  type = string
}

variable "private_dns_zone_id" {
  type = string
  default = null
}

variable "private_endpoint" {
  description = "(Required) Private endpoint object"
  type = any
  default = {}
}
