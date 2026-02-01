resource "yandex_compute_disk" "storage_disks" {
  count = 3

  name = "storage-disk-${count.index + 1}"
  size = 1
  type = "network-hdd"
  zone = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  zone        = var.default_zone
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd8lcd9f54ldmonh1d72"
      size     = 10
      type     = "network-hdd"
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disks
    content {
      disk_id = secondary_disk.value.id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = true
  }

  metadata = local.metadata
}
