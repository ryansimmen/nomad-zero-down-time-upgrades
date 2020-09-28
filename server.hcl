job "example" {
  datacenters = ["dc1"]
  type = "service"
  group "example" {

    count = 1

    update {
      max_parallel     = 1
      canary           = 1
      min_healthy_time = "2s"
      auto_revert      = true
      auto_promote     = true
    }

    network {
      port "http" { }
    }

    service {
      name = "example"
      port = "http"

      check {
        type     = "http"
        path     = "/_ping"
        interval = "5s"
        timeout  = "2s"
      }
    }

    task "example" {

      driver = "docker"

      kill_timeout = "10s"

      config {
        image = "web-server:1.0"
        network_mode = "host"
      }

      env {
        HTTP_PORT = "${NOMAD_PORT_http}"
        VERSION = "1"
      }
    }
  }
}
