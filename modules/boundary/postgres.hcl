container "postgres" {
    image {
        name = "postgres:${var.boundary_postgres_version}"
    }

    port {
        local  = 5432
        host   = 5432
        remote = 5432
    }

    env {
        key   = "POSTGRES_USER"
        value = var.boundary_postgres_user
    }

    env {
        key   = "POSTGRES_PASSWORD"
        value = var.boundary_postgres_password
    }

    volume {
        source      = "./config/postgres/files"
        destination = "/files"
    }

    network {
        name = "network.${var.network}"
    }

}

exec_remote "psql_checker" {

    target = "container.postgres"

    cmd = "sh"
    args = [
        // "-c",
        "./files/psql-checker.sh"

    ]

    network {
        name = "network.${var.network}"
    }

    depends_on = [
        "container.postgres"
    ]
}
