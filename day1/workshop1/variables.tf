variable DO_token {
    type = string
    sensitive = true
}

variable DB_user {
    type = string
    sensitive = true
}

variable DB_pw {
    type = string
    sensitive = true
}

variable mynet {
    type = string
    default = "mynet"
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
    default = "s-1vcpu-1gb"
}

variable DO_private_key{
    type = string
    default = "/home/fred/root_id_rsa"
}

/* variable nw_images {
    type = map(object({
        image_name = string
        port = number
    }))

    default = {
        nwdb = {
            image_name = "stackupiss/northwind-db:v1"
            port = ""
        }
        nwapp = {
            image_name = "stackupiss/northwind-app:v1"
            port = ""
        }
    }
} */