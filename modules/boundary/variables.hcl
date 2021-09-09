# Postgres variables
variable "network" {
  default = "cloud"
}

variable "boundary_postgres_version" {
  default = "latest"
}

variable "boundary_postgres_user" {
  default = "postgres"
}

variable "boundary_postgres_password" {
  default = "postgres"
}

# Boundary variables

variable "boundary_version" {
  default = "0.5.0"
}