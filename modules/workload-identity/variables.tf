variable "project_id" {
  description = "GCP Service project ID"
  type        = string
}

variable "external_project_id" {
  description = "GCP Project what host the resource that needs to be accessed"
  type        = string
  default     = null
}

variable "gcp_sa_name" {
  description = "Name for the Google service account; overrides."
  type        = string
  default     = null
}

variable "use_existing_gcp_sa" {
  description = "Use an existing Google service account instead of creating one"
  type        = bool
  default     = false
}

variable "external_gsa_project" {
  description = "Is the GSA located in an different project?"
  type        = bool
  default     = false
}

variable "create_key" {
  description = "Create Authetication Key for Service Account"
  type        = bool
  default     = false
}

variable "k8s_sa_name" {
  description = "Name for the Kubernetes service account; overrides."
  type        = string
  default     = null
}

variable "namespace" {
  description = "Namespace for the Kubernetes service account"
  type        = string
  default     = "default"
}

variable "stage" {
  description = "Environment the account will be created on"
  type        = string
  default     = "default"
}

variable "roles" {
  description = "A list of roles to be added to the created service account"
  type        = list(string)
  default     = []
}
