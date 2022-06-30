[Unit]
Description=code-server
After=nginx.service

[Service]
Type=simple
Environment=PASSWORD="${code-server-password}"
ExecStart=/usr/bin/code-server --bind-addr 127.0.0.1:8080 --user-data-dir /var/lib/code-server --auth password
Restart=always

[Install]
WantedBy=multi-user.target
