output "google_api_psc_endpoints" {
  description = "Google API PSC endpoint details (global)"
  value = {
    for k, v in module.google_api_psc : k => {
      ip                 = v.psc_endpoint_ip
      forwarding_rule_id = v.forwarding_rule_id
    }
  }
}

# output "google_api_psc_regional_endpoints" {
#   description = "Google API PSC endpoint details (regional)"
#   value = {
#     for k, v in module.google_api_psc_regional : k => {
#       ip                 = v.psc_endpoint_ip
#       forwarding_rule_id = v.forwarding_rule_id
#     }
#   }
# }

# output "service_attachment_psc_endpoints" {
#   description = "Service attachment PSC endpoint details"
#   value = {
#     for k, v in module.service_attachment_psc : k => {
#       ip                 = v.psc_endpoint_ip
#       forwarding_rule_id = v.forwarding_rule_id
#     }
#   }
# }
