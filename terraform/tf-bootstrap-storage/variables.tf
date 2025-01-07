variable "location" {
  description = "Location for the resources"
  type        = string
  default     = "West Europe"
}

variable "bootstrap_resource_group_name" {
  description = "Name of the resource group for bootstrap storage"
  type        = string
}

variable "bootstrap_storage_account_name" {
  description = "Name of the storage account for bootstrap storage"
  type        = string
}

variable "bootstrap_container_name" {
  description = "Name of the storage container for bootstrap storage"
  type        = string
}
