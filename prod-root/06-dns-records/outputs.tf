output "dns_records" {
  description = "Map of created DNS records"
  value = {
    for k, v in module.dns_records : k => {
      name = v.record_name
      type = v.record_type
      fqdn = v.record_fqdn
    }
  }
}