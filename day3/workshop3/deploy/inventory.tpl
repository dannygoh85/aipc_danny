all:
  vars:
      ansible_user: ${ansible_user}
      ansible_connection: ${ansible_connection}
      ansible_ssh_private_key_file: ${ansible_ssh_key_path}

  hosts:
    server-0:
      ansible_host: ${host_ip}
