locals {
  metadata = {
    "serial-port-enable" = 1
    "ssh-keys"           = "ubuntu:${file("~/.ssh/for_yandex.pub")}"
  }
}
