variable "network_id" {
  description = "ID of the VPC network"
  type        = string
}

variable "region" {
  description = "OpenStack region"
  type        = string
  default     = "ru-9"
}

variable "zone_to_subnet_name" {
  description = "Map of availability zone -> subnet name"
  type        = map(string)
}
