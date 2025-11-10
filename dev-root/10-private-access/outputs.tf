output "psc_endpoints" {
  description = "Map of created PSC endpoints"
  value = {
    for k, v in module.psc_endpoints : k => {
      name = v.endpoint_name
      ip   = v.psc_internal_ip
    }
  }
}