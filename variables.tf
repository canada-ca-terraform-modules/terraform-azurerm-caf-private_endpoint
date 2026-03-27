variable "tags" {
  description = "Tags to be applied to the private endpoint"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "(Required) Name of the private endpoint"
  type        = string
}

variable "resource_groups" {
  description = "(Required) Resource group object of private endpoint"
  type        = any
  default     = {}
}

variable "location" {
  description = "Azure location where the private endpoint will be located"
  type        = any
  default     = "canadacentral"
}

variable "subnets" {
  description = "(Required) Map of subnets"
  type        = any
  default     = {}
}

variable "private_connection_resource_id" {
  description = "(Required) The ID of the resource the private endpoint will be connected to"
  type        = string
}

variable "private_dns_zone_ids" {
  description = "List of private DNS zone ids"
  type        = any
  default     = {}
}

variable "private_endpoint" {
  description = "(Required) Private endpoint object"
  type        = any
  default     = {}
}

variable "custom_network_interface_name" {
  description = "(Optional) The custom name of the network interface attached to the private endpoint. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "ip_configuration" {
  description = "(Optional) One or more ip_configuration blocks to set static IP addresses for the private endpoint. Each block requires: name, private_ip_address; optional: subresource_name, member_name."
  type        = any
  default     = []
}
