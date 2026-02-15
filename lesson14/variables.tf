variable "auth_url" {
  description = "OpenStack Auth URL"
  type        = string
  default     = "https://cloud.api.selcloud.ru/identity/v3/"
}

variable "domain_name" {
  description = "Account ID"
  type        = string
}

variable "tenant_id" {
  description = "Project ID"
  type        = string
}

variable "user_name" {
  description = "Service user name"
  type        = string
}

variable "password" {
  description = "Service user password"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Region"
  type        = string
  default     = "ru-9"
}

variable "public_key_path" {
  description = "Path to public SSH key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to private SSH key"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "flavor_id" {
  description = "OpenStack flavor ID for instances"
  type        = string
  default     = "1011"
}

variable "volume_type" {
  description = "Volume type for boot volumes (например, fast.ru-9a)"
  type        = string
  default     = "fast.ru-9a"
}

variable "availability_zone" {
  description = "Availability zone"
  type        = string
  default     = "ru-9a"
}
