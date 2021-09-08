variable "network" {
    default = "cloud"
}

container "rabbitmq" {
    network {
        name = "network.${var.network}"
    }

    image {
        name = "rabbitmq:3-management"
    }
    
    port {
      host = "15672"
      remote = "15672"
      local = "15672"
    }

    port {
      host = "5672"
      remote = "5672"
      local = "5672"
    }

    port {
      host = "15671"
      remote = "15671"
      local = "15671"
    }
}
