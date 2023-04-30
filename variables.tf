variable "name" {
  description = "Name of the App Configuration."
  type        = string
}

variable "location" {
  description = "Location to create the App Configuration in, if different from the resource group location (Optional)."
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "Name of the resource group to create the App Configuration in."
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to resource"
  type        = map(string)
  default     = null
}

variable "key_values" {
  type = map(object(
    {
      key   = string
      value = string
      label = string
    }
  ))
  description = <<EOT
  App Configuration Key Values:

  EOT
  default     = null
}

variable "key_values_kv_reference" {
  type = map(object(
    {
      key                 = string
      vault_key_reference = string
      label               = string
    }
  ))
  description = "key value reference from key vault"
  default     = null
}

variable "feature_flags" {
  type = map(object(
    {
      name        = string
      enabled     = bool
      description = string
      label       = string
    }
  ))
  description = "App Configuration Feature Flags"
  default     = null
}
