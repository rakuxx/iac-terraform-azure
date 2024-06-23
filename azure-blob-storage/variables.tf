variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "West Europe"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "service_plan_name" {
  description = "The name of the service plan"
  type        = string
}

variable "function_app_name" {
  description = "The name of the function app"
  type        = string
}

variable "function_name" {
  description = "The name of the function"
  type        = string
}
