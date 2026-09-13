variable "location" {
  description = "Azure region for the Terraform state resources."
  type        = string
  default     = "francecentral"
}

variable "resource_group_name" {
  description = "Resource group containing the Terraform state storage account."
  type        = string
  default     = "rg-mbk-tfstate-prod"
}

variable "storage_account_name" {
  description = "Globally unique storage account name used for Terraform state."
  type        = string
}

variable "container_name" {
  description = "Blob container used for Terraform state files."
  type        = string
  default     = "tfstate"
}

variable "tags" {
  description = "Tags applied to bootstrap resources."
  type        = map(string)
  default = {
    owner       = "platform"
    workload    = "terraform-state"
    environment = "prod"
    managed-by  = "terraform"
  }
}
