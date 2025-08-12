source "yandex" "debian_docker" {
  disk_type           = "network-hdd"
  folder_id           = "b1gvv9rtrnndrv3n6mmt"
  image_description   = "my custom debian with docker"
  image_name          = "debian-11-docker"
  source_image_family = "debian-11"
  ssh_username        = "debian"
  subnet_id           = "e9bv1hf6tojiasrg3k2b"
  token               = var.token
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}

build {
  sources = ["source.yandex.debian_docker"]

  provisioner "shell" {
    inline = ["echo 'hello from packer'"]
  }

}