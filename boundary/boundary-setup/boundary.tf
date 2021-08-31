provider "boundary" {
  addr             = "http://localhost:9200/"
  recovery_kms_hcl = <<EOT
kms "aead" {
  purpose = "recovery"
  aead_type = "aes-gcm"
  key = "nIRSASgoP91KmaEcg/EAaM4iAkksyB+Lkes0gzrLIRM="
  key_id = "global_recovery"
}
EOT
}

module "boundary_starter_org" {
  source = "devops-rob/getting-started/boundary"
  version = "0.1.2"

  login_account_name        = "admin"
  login_account_password    = "foofoofoo"
  login_account_description = "Admin user for initial configuration"

  org_name        = "officehours"
  org_description = "Office Hours org scope"

  project_name        = "developeradvocates"
  project_description = "Project for the Developer Advocates team"
}