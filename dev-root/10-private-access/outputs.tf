output "psc_endpoints" {
  description = "Map of created PSC endpoints with IPs"
  value = {
    for k, v in module.psc_endpoints : k => {
      ip = v.psc_internal_ip
    }
  }
}