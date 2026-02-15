output "subnet_map" {
  description = "Map of zone -> subnet_id"
  value       = local.zone_to_id
}
