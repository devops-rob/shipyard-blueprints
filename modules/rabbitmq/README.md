# RabbitMQ blueprint for Shipyard

This blueprint will give you a containerised RabbitMQ server.

## Requirements

- Requires [shipyard](https://shipyard.run/) 0.3.29 or later

### Resources

- RabbitMQ container

### Example usage

#### Minimal example

```hcl
network "cloud" {
  subnet = "10.6.0.0/16"
}

module "rabbitmq" {
    source = "github.com/devops-rob/shipyard-blueprints/modules//rabbitmq"
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

variable "rabbitmq_version" {
  default = "management"
}

module "rabbitmq" {
    source = "github.com/devops-rob/shipyard-blueprints/modules//rabbitmq"
}
```

### Optional inputs

| Variable | Default |
| -------- | ------- |
| network  | cloud   |
| rabbitmq_version | 3-management |
