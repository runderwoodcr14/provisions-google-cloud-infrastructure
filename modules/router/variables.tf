variable "name" {
  type        = string
  description = "Name of the router"
}

variable "network" {
  type        = string
  description = "A reference to the network to which this router belongs"
}

variable "project" {
  type        = string
  description = "The project ID to deploy to"
}

variable "region" {
  type        = string
  description = "Region where the router resides"
}

variable "description" {
  type        = string
  description = "An optional description of this resource"
  default     = null
}

# Type: object, with fields:
# - asn (string, required): Local BGP Autonomous System Number (ASN).
# - advertised_groups (list(string), optional): User-specified list of prefix groups to advertise.
# - advertised_ip_ranges (list(object), optional): User-specified list of individual IP ranges to advertise.
#   - range (string, required): The IP range to advertise.
#   - description (string, optional): User-specified description for the IP range.
variable "bgp" {
  description = "BGP information specific to this router."
  type        = any
  default     = null
}
