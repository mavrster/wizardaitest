variable "environment" {
  description = "Environment name (development, staging, production)"
  type        = string

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "The environment must be one of 'development', 'staging' or 'production'."
  }
}

variable "bucket_suffix" {
  description = "S3 bucket name suffix"
  type        = string
}

variable "default_tags" {
  description = "Default tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "block_public_access" {
  description = "Whether to enable public access"
  type        = bool
  default     = true
}

variable "bucket_ownership" {
  description = "bucket ownership setting"
  type        = string
  default     = "BucketOwnerEnforced"
}

variable "enable_object_lock" {
  description = "Whether to enable object locking"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Flag to enable bucket versioning"
  type        = bool
  default     = false
}

variable "force_destroy" {
  description = "Whether to enable bucket destroy with objects"
  type        = bool
  default     = false
}

variable "lifecycle_configuration_enabled" {
  description = "Flag on whether to enable lifecycle configuraiton - expiration"
  type        = bool
  default     = false
}

variable "lifecycle_configuration_expiration_days" {
  description = "Number of days before the data is deleted"
  type        = number
  default     = 2555
}

variable "lifecycle_configuration_status" {
  description = "Whether the lifecycle configuration is enabled"
  type        = string
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Disabled"], var.lifecycle_configuration_status)
    error_message = "Valid values for var: Enabled, Disabled."
  }
}
