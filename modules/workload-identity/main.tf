locals {
  # GCP service account ids must be < 30 chars matching regex ^[a-z](?:[-a-z0-9]{4,28}[a-z0-9])$
  # KSAs do not have this naming restriction.
  gcp_given_name                  = var.use_existing_gcp_sa ? var.gcp_sa_name : module.gcp_sa_label.id
  gcp_sa_email                    = var.use_existing_gcp_sa ? data.google_service_account.cluster_service_account[0].email : google_service_account.cluster_service_account[0].email
  gcp_sa_id                       = var.use_existing_gcp_sa ? data.google_service_account.cluster_service_account[0].name : google_service_account.cluster_service_account[0].name
  gcp_sa_fqn                      = "serviceAccount:${local.gcp_sa_email}"
  k8s_sa_gcp_derived_name         = "serviceAccount:${var.project_id}.svc.id.goog[${var.namespace}/${var.k8s_sa_name}]"
  given_project                   = var.external_project_id != null ? var.external_project_id : var.project_id
  given_external_internal_project = var.external_gsa_project ? var.external_project_id : var.project_id
}

module "gcp_sa_label" {
  source    = "cloudposse/label/null"
  namespace = var.namespace
  name      = var.gcp_sa_name
  delimiter = "-"
}

data "google_service_account" "cluster_service_account" {
  count = var.use_existing_gcp_sa ? 1 : 0

  account_id = var.gcp_sa_name
  project    = local.given_external_internal_project
}

resource "google_service_account" "cluster_service_account" {
  count        = var.use_existing_gcp_sa ? 0 : 1
  account_id   = local.gcp_given_name
  display_name = substr("GCP SA bound to K8S SA ${var.k8s_sa_name}", 0, 100)
  project      = local.given_external_internal_project
}

resource "google_service_account_key" "cluster_service_account_key" {
  count              = var.create_key ? 1 : 0
  service_account_id = google_service_account.cluster_service_account.0.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "google_service_account_iam_member" "wiu_role_binding" {
  service_account_id = local.gcp_sa_id
  role               = "roles/iam.workloadIdentityUser"
  member             = local.k8s_sa_gcp_derived_name
}

resource "google_project_iam_member" "workload_identity_sa_bindings" {
  for_each = toset(var.roles)
  project  = local.given_project
  role     = each.value
  member   = local.gcp_sa_fqn
}
