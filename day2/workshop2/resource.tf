data digitalocean_ssh_key aipc{
    name = "aipc"
}

resource digitalocean_droplet ws2gninxansible {
  name = "ws2gninxansible"
  image = var.DO_image
  size = var.DO_size
  region = var.DO_region

  ssh_keys = [data.digitalocean_ssh_key.aipc.id]

  connection {
    type = "ssh"
    user = "root"
    private_key = file(var.DO_private_key)
    host = self.ipv4_address
  }

  provisioner remote-exec {
    inline = [
        "apt update",
        "apt install nginx -y",
        "systemctl enable nginx",
        "systemctl start nginx"
    ]
  }

/*   provisioner file {
    source = "./nginx.conf"
    destination = "/etc/nginx/nginx.conf"
  } */

    provisioner remote-exec {
    inline = [
        "systemctl restart nginx"
    ]
  }
}

output nginx_ip {
    value = digitalocean_droplet.ws2gninxansible.ipv4_address
}

resource local_file inventory {
    content = templatefile("./inventory.tpl", {
      host_ip = digitalocean_droplet.ws2gninxansible.ipv4_address
    })
    filename = "inventory.yaml"
    file_permission = "0444"
}