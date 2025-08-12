source "yandex" "debian_docker" {
  disk_type           = "network-hdd"
  platform_id         = "standard-v3"
  folder_id           = "b1gvv9rtrnndrv3n6mmt"
  image_description   = "Debian 11 with Docker, htop, tmux (Packer)"
  image_name          = "debian-11-docker"
  source_image_family = "debian-11"
  ssh_username        = "debian"
  subnet_id           = "e9bmlcb4s7ejpc1kb03f"
  token               = var.token
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}

build {
  sources = ["source.yandex.debian_docker"]

  provisioner "shell" {
    inline = [
      "set -euxo pipefail",
      "export DEBIAN_FRONTEND=noninteractive",
      "apt-get update",
      "apt-get install -y ca-certificates curl gnupg htop tmux",
      "install -m 0755 -d /etc/apt/keyrings",
      "curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
      "chmod a+r /etc/apt/keyrings/docker.gpg",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo $VERSION_CODENAME) stable\" > /etc/apt/sources.list.d/docker.list",
      "apt-get update",
      "apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
      "usermod -aG docker ${SSH_USERNAME:-debian} || true",
      "systemctl enable docker || true"
    ]
  }
}