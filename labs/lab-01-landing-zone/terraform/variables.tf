variable "location" {
  description = "Azure region for the lab Resource Group."
  type        = string
  default     = "francecentral"
}

variable "tags" {
  description = "Baseline tags for MayaBank lab resources."
  type        = map(string)
  default = {
    Application        = "azure-landing-zone-lab"
    Environment        = "lab"
    Owner              = "platform-team"
    CostCenter         = "LAB"
    Criticality        = "low"
    DataClassification = "internal"
    ManagedBy          = "terraform"
    BusinessUnit       = "platform"
    Lifecycle          = "ephemeral"
  }
}
