# Kafka blueprint for Shipyard

This blueprint will give you a containerised RabbitMQ server.

## Requirements

- Requires [shipyard](https://shipyard.run/) 0.3.29 or later

### Resources

- Kafka container
- Zooper container
- Kafka UI container

### Example usage

#### Minimal example

```hcl
network "cloud" {
  subnet = "10.6.0.0/16"
}

module "boundary" {
    source = "github.com/devops-rob/shipyard-blueprints/modules//kafka"
}
```

#### Variable example

```hcl
network "test" {
  subnet = "10.6.0.0/16"
}

variable "network" {
  default = "test"
}

variable "kafka_ui_version" {
  default = "0.1.0"
}

variable "kafka_ui_port" {
  default = "8081"
}

variable "kafka_version" {
  default = "2.8.0"
}

variable "zookeeper_version" {
  default = "3.7.0"
}

module "kafka" {
    source = "github.com/devops-rob/shipyard-blueprints/modules//kafka"
}
```

### Optional inputs

| Variable | Default |
| -------- | ------- |
| network  | cloud   |
| kafka_ui_version | 0.2.0 |
| kafka_ui_port | 8080 |
| kafka_version | 2.8.0-debian-10-r97 |
| zookeeper_version | 3.7.0-debian-10-r142 |
