data docker_image northwind-app {
    name = "stackupiss/northwind-app:v1"
}

data docker_image northwind-db {
    name = "stackupiss/northwind-db:v1"
}

resource docker_network mynet {
  name = "mynet"
}

resource docker_volume db_volume {
  name = "db_volume"
}

resource docker_container mynorthwinddb{
    name = "mynorthwinddb"
    image = data.docker_image.northwind-db.id

    ports {
        internal = 3306
        external = 3306
    }
     volumes {
         volume_name = docker_volume.db_volume.name
         container_path = "/var/lib/mysql"
    }
 networks_advanced {
   name = var.mynet
 }
}

resource docker_container mynorthwindapp {
 name = "mynorthwindapp"
 image = data.docker_image.northwind-app.id
 env = [
    "DB_HOST=${docker_container.mynorthwinddb.name}",
    "DB_USER=${var.DB_user}",
    "DB_PASSWORD=${var.DB_pw}"
 ]
 networks_advanced {
   name = var.mynet
 }
 ports {
   internal = 3000
   external = 3000
 }
}

/* resource docker_image app_images {
    for_each = var.nw_images
    name = each.value.image_name
} */
