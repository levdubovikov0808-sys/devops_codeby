variable "instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "flavor_id" {
  description = "Flavor ID"
  type        = string
}

variable "image_id" {
  description = "Image ID"
  type        = string
}

variable "key_pair_name" {
  description = "SSH key pair name"
  type        = string
}

variable "network_id" {
  description = "ID of the network"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the instance"
  type        = string
}

variable "subnet_map" {
  description = "Map of zone -> subnet_id"
  type        = map(string)
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

variable "volume_size" {
  description = "Size of the boot volume in GB"
  type        = number
  default     = 10
}

variable "volume_type" {
  description = "Volume type"
  type        = string
  default     = "fast.ru-9a"
}

variable "assign_floating_ip" {
  description = "Assign a floating IP to the instance"
  type        = bool
  default     = false
}
