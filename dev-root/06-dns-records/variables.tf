variable "dns_records" {
  description = "Map of DNS records to create - Super simple for developers"
  type = map(object({
    project_id  = string
    dns_suffix  = string        # Domain developers know (e.g., "internal.visa.com.")
    record_name = string        # Just the record name (e.g., "api", "web")
    type        = string        # Record type (A, CNAME, MX, etc.)
    ttl         = number        # Time to live in seconds
    rrdatas     = list(string)  # Record data: IPs for A, domains for CNAME, etc.
  }))
}