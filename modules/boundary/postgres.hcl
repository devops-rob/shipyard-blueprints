container "postgres" {
    image {
        name = "postgres:latest"
    }

    port {
        local  = 5432
        host   = 5432
        remote = 5432
    }

    env {
        key   = "POSTGRES_USER"
        value = "postgres"
    }

    env {
        key   = "POSTGRES_PASSWORD"
        value = "postgres"
    }

    volume {
        source      = "./config/postgres/files"
        destination = "/files"
    }

    network {
        name       = "network.onprem"
    }

}

exec_remote "psql_checker" {

    target = "container.postgres"

    cmd = "sh"
    args = [
        // "-c",
        "./files/psql-checker.sh"

    ]
    depends_on = [
        "container.postgres"
    ]
}
