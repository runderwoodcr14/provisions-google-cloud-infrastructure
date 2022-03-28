resource "random_string" "suffix" {
  length  = 30 - length(var.parent) - 1
  upper   = false
  number  = false
  special = false
}



module "add-project" {
  source  = "terraform-google-modules/project-factory/google//modules/svpc_service_project"
  version = "~> 12.0.0"

  name               = "${var.prefix}-${var.environment}-${random_string.suffix.result}"
  org_id             = var.org_id
  folder_id          = var.parent
  billing_account    = var.billing_account_id
  shared_vpc         = var.host-project
  activate_apis      = var.project_services
  project_sa_name    = "${var.environment}-service-account"
  shared_vpc_subnets = local.shared_subnets
}

resource "google_project_iam_member" "bind_roles_default_sa" {
  for_each = var.roles
  project  = var.host-project
  role     = "roles/${each.value}"
  member   = "serviceAccount:${module.add-project.service_account_email}"
}

resource "google_project_iam_member" "bind_roles_project_sa" {
  for_each = var.roles
  project  = var.host-project
  role     = "roles/${each.value}"
  member   = "serviceAccount:service-${module.add-project.project_number}@container-engine-robot.iam.gserviceaccount.com"

}
