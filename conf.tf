variable "gcp_project" {
  type    = "string"
  default = "hc-terraform-testing"
}

module "iam-module" {
  source = "./iam-account"
}

resource "google_service_account" "test" {
  account_id   = "tf-paddy-test"
  display_name = "Issue 11736"
}

data "google_iam_policy" "bindings" {
  binding {
    role = "roles/viewer"

    members = [
      "serviceAccount:${google_service_account.test.email}",
    ]
  }
}

resource "google_project_iam_policy" "google-project" {
  project       = "${var.gcp_project}"
  policy_data   = "${data.google_iam_policy.bindings.policy_data}"
  authoritative = false
}
