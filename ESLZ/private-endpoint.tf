terraform {
  required_version = ">= 1.9"
}

variable "private_endpoint" {
  description = "Map of private endpoint configuration objects"
  type        = any
  default     = {}
}

variable "private_connection_resource_id" {
  description = "The ID of the resource the private endpoint will be connected to"
  type        = string
  default     = null
}

variable "resource_groups" {
  description = "Map of resource group objects"
  type        = any
  default     = {}
}

variable "subnets" {
  description = "Map of subnet objects"
  type        = any
  default     = {}
}

variable "private_dns_zone_ids" {
  description = "Map of private DNS zone IDs, keyed by zone name"
  type        = any
  default     = {}
}

variable "location" {
  description = "Azure location for the private endpoint"
  type        = string
  default     = "canadacentral"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

module "private_endpoint" {
  source   = "github.com/ssc-spc-ccoe-cei/terraform-azurerm-caf-private_endpoint?ref=v1.2.0"
  for_each = var.private_endpoint

  name                           = each.key
  private_connection_resource_id = var.private_connection_resource_id
  resource_groups                = var.resource_groups
  subnets                        = var.subnets
  private_dns_zone_ids           = var.private_dns_zone_ids
  location                       = var.location
  tags                           = var.tags
  private_endpoint               = each.value
}
