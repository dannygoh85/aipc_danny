all:
  vars:
      ansible_user: root
      ansible_connection: ssh
      ansible_ssh_private_key_file: /home/fred/.ssh/root_id_rsa
      packages_to_install:
      - name: nginx
        state: started
      - name: mysql-server
        state: started

  hosts:
    server-0:
      ansible_host: ${host_ip}
