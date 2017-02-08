variable "gcp_project" {
  type    = "string"
  default = "hc-terraform-testing"
}

resource "google_project_iam_policy" "google-project" {
  project       = "${var.gcp_project}"
  policy_data   = "${data.google_iam_policy.policy-bindings.policy_data}"
  authoritative = false
}

data "google_iam_policy" "policy-bindings" {
  binding {
    role = "roles/viewer"

    members = [
      "user:paddy@carvers.co",
    ]
  }

  binding {
    role = "roles/viewer"

    members = [
      "user:paddy@hashicorp.com",
    ]
  }
}
