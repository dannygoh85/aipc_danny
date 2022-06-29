data digitalocean_ssh_key aipc{
    name = "aipc"
}

resource local_file aipc_public_key {
    filename = "aipc.pub"
    content = data.digitalocean_ssh_key.aipc.public_key
    file_permission = "644"
}
output aipc_ssh_key{
    value = data.digitalocean_ssh_key.aipc.fingerprint
}

output aipc_ssh_id{
    value = data.digitalocean_ssh_key.aipc.id
}



data docker_image dov-bear {
    name = "chukmunnlee/dov-bear:v2"
}

resource docker_container dov-bear-container {
    count = length(var.ports)
    name = "dov-bear-${count.index}"
    image = data.docker_image.dov-bear.id
    
    env = [
        "INSTANCE_NAME=myapp-${count.index}"
    ]
    ports {
        internal = 3000
        external = var.ports[count.index]
    }
}

resource docker_container dov-bear-unique {
    for_each = var.containers
    name = each.key
    image = data.docker_image.dov-bear.id
    
    env = [
        "INSTANCE_NAME=myapp-${each.key}"
    ]
    ports {
        internal = 3000
        external = each.value.external_port
    }
}

output dov-bear-md5 {
    value = data.docker_image.dov-bear.repo_digest
    description = "SHA"
}

output dov-container-names {
    value = [ for c in docker_container.dov-bear-container: c.name ]
}

resource local_file container-names {
    content = join(",", [ for c in docker_container.dov-bear-container: c.name ])
    filename = "conatiner_file.txt"
    file_permission = 0644
}