variable DO_token {
    type = string
    sensitive = true
}

variable DO_image{
    type = string
    default = "ubuntu-20-04-x64"
}

variable DO_region{
    type = string
    default = "sgp1"
}

variable DO_size{
    type = string 
    default = "s-1vcpu-2gb"
}

variable DO_private_key{
    type = string
    default = "/home/fred/.ssh/root_id_rsa"
}

variable ansible_connection{
    type = string
    default = "ssh"
}

variable ansible_user{
    type = string
    default = "root"
}

variable code-server-password{
    type = string
    default = "mypassword"
}

variable code-server-version{
    type = string
    default = "v4-4-0"
}