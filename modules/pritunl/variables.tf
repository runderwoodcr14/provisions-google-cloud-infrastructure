variable "project" {
  default = ""
}

variable "parent" {
  default = ""
}

variable "region" {
  default = "europe-west1"
}

#===============================================
# Count of PVE servers
#===============================================
variable "count_instance" {
  default = "1"
}

variable "zone_instance" {
  default = "europe-west1-d"
}

variable "disk_image" {
  default = "ubuntu-2004-focal-v20210720"
}

variable "instance_tag" {
  default = "vpn-server"
}

variable "subnet"{
  type = string
}

variable "service_account"{
  type = string
}

variable "can_ip_forward"{
  type    = bool
  default = true
}
