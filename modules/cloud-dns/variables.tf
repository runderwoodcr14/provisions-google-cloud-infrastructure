variable "project_id" {
  description = "Project id where the zone will be created."
  default     = ""
}

variable "network" {
  description = "Self link of the network that will be allowed to query the zone."
  default     = []
  type        = list(string)
}

variable "name" {
  description = "DNS zone name."
  default     = "foo-local"
}

variable "domain" {
  description = "Zone domain."
  default     = "foo.local."
}

variable "labels" {
  type        = map(any)
  description = "A set of key/value label pairs to assign to this ManagedZone"
  default = {
    owner   = "foo"
    version = "bar"
  }
}

variable "type" {
  description = "Type of zone to create, valid values are 'public', 'private', 'forwarding', 'peering'."
  default     = "private"
  type        = string
}

variable "force_destroy" {
  description = "Set this true to delete all records in the zone."
  default     = false
  type        = bool
}

variable "recordsets" {
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
  description = "List of DNS record objects to manage, in the standard terraform dns structure."
  default     = []
}
