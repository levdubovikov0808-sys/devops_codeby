variable "auth_url" {
  default = "https://cloud.api.selcloud.ru/identity/v3/"
}

variable "domain_name" {
  description = "Account ID (номер аккаунта Selectel)"
  type        = string
}

variable "tenant_id" {
  description = "Project ID (UUID проекта)"
  type        = string
}

variable "user_name" {
  description = "Service user name (имя сервисного пользователя)"
  type        = string
}

variable "password" {
  description = "Service user password"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Region (например, ru-9)"
  default     = "ru-9"
}

variable "network_id" {
  description = "ID of the existing VPC network"
  type        = string
}

variable "zone_to_subnet_name" {
  description = "Map of availability zone -> subnet name"
  type        = map(string)
  default = {
    "ru-9a" = "public-subnet"
    "ru-9b" = "private-subnet"
  }
}

variable "target_zone" {
  description = "Availability zone for the new VM"
  type        = string
  default     = "ru-9a"
}

variable "instance_name" {
  description = "Name of the instance"
  type        = string
  default     = "lesson15-vm"
}

variable "flavor_id" {
  description = "Flavor ID"
  type        = string
  default     = "1011"
}

variable "image_name" {
  description = "Image name (will be resolved to ID)"
  type        = string
  default     = "Ubuntu 22.04 LTS 64-bit"
}

variable "key_pair_name" {
  description = "SSH key pair name"
  type        = string
  default     = "lesson14-key"
}

variable "security_group_ids" {
  description = "Security group IDs"
  type        = list(string)
  default     = []
}

variable "assign_floating_ip" {
  description = "Assign floating IP to the VM"
  type        = bool
  default     = true
}
