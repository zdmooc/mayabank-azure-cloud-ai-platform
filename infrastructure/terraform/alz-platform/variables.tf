variable "location" {
  description = "Default Azure region used by ALZ policy managed identities. Validate service availability and data-residency requirements before production use."
  type        = string
  default     = "francecentral"
}

variable "enable_telemetry" {
  description = "Controls telemetry for the Azure Verified Module."
  type        = bool
  default     = false
}
