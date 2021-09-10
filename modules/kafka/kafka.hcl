container "zookeeper" {
    network {
        name = "network.${var.network}"
    }

    image {
        name = "bitnami/zookeeper:${var.zookeeper_version}"
    }
    
    port {
      host = "2181"
      remote = "2181"
      local = "2181"
    }

    env_var = {
      ALLOW_ANONYMOUS_LOGIN = "yes"
    }
}

container "kafka" {
    network {
        name = "network.${var.network}"
    }

    image {
        name = "bitnami/kafka:${var.kafka_version}"
    }

    port {
      host = "9092"
      remote = "9092"
      local = "9092"
    }

    env_var = {
      KAFKA_BROKER_ID = "1"
      KAFKA_LISTENERS = "PLAINTEXT://:9092"
      KAFKA_ADVERTISED_LISTENERS = "PLAINTEXT://kafka.container.shipyard.run:9092"
      KAFKA_ZOOKEEPER_CONNECT = "zookeeper.container.shipyard.run:2181"
      ALLOW_PLAINTEXT_LISTENER = "yes"
    }
    volume {
      source = "./scripts"
      destination = "/scripts"
    }
}

container "kafka_ui" {
    network {
        name = "network.${var.network}"
    }

    image {
        name = "provectuslabs/kafka-ui:${var.kafka_ui_version}"
    }

    port {
      host = var.kafka_ui_port
      remote = var.kafka_ui_port
      local = var.kafka_ui_port
      open_in_browser = "http://localhost:${var.kafka_ui_port}"
    }
    
    health_check {
        timeout = "120s"
        http    = "http://localhost:${var.kafka_ui_port}"
    }

    env_var = {
      KAFKA_CLUSTERS_0_NAME="PLAINTEXT"
      KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS="kafka.container.shipyard.run:9092"
      KAFKA_CLUSTERS_0_ZOOKEEPER="zookeeper.container.shipyard.run:2181"
    }
}

exec_remote "kafka_ready" {

    target = "container.kafka"
 
    network {
        name = "network.${var.network}"
    }

    cmd = "sh"
    args = ["./scripts/kafka-checker.sh"]

    depends_on = [
        "container.kafka",
    ]
}