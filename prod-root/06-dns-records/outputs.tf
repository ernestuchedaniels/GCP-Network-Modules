output "dns_records" {
  description = "Map of created DNS records"
  value = {
    for k, v in var.dns_records : k => {
      name = v.record_name
      type = v.type
      fqdn = "${v.record_name}.${v.dns_suffix}"
    }
  }
}