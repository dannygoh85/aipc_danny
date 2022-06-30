data digitalocean_ssh_key aipc{
    name = "aipc"
}

data digitalocean_image golden-image{
  name = "packer-golden-image"
}

resource digitalocean_droplet ws2gninxansible {
  name = "ws2gninxansible"
  image = data.digitalocean_image.golden-image.image
  size = var.DO_size
  region = var.DO_region
  tags = [ "CodeServer${var.code-server-version}" ]
  ssh_keys = [data.digitalocean_ssh_key.aipc.id]

  connection {
    type = "ssh"
    user = "root"
    private_key = file(var.DO_private_key)
    host = self.ipv4_address
  }
}

output server_ip {
    value = "code-${digitalocean_droplet.ws2gninxansible.ipv4_address}.nip.io"
}

resource local_file inventory {
    content = templatefile("./inventory.tpl", {
      host_ip = digitalocean_droplet.ws2gninxansible.ipv4_address,
      ansible_user = var.ansible_user,
      ansible_connection = var.ansible_connection,
      ansible_ssh_key_path = var.DO_private_key,
    })
    filename = "inventory.yaml"
    file_permission = "0444"
}

resource local_file code-server-conf {
    content = templatefile("./code-server.conf.tpl", {
      host_ip = digitalocean_droplet.ws2gninxansible.ipv4_address
    })
    filename = "code-server.conf.j2"
    file_permission = "0444"
}

resource local_file code-server-service {
    content = templatefile("./code-server.service.tpl", {
      code-server-password = var.code-server-password
    })
    filename = "code-server.service.j2"
    file_permission = "0444"
}