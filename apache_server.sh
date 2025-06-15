#!/bin/bash

echo "Deploying webpage..."

# Install apache
sudo apt update && sudo apt upgrade -y
sudo apt install apache2 -y

# Verify apache
if sudo systemctl status apache2 | grep -q 'active (running)'; then
  echo "Apache running..."
else
  sudo systemctl status apache2 --no-pager
  exit 1
fi

# Delete default page
sudo rm -f /var/www/html/index.html

# Firewall configuration
sudo ufw allow 80/tcp

# New webpage deployment
cd /var/www/html

sudo tee index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>¡DevOps en Acción!</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
        h1 { color: #2c3e50; }
        .logo { width: 150px; }
    </style>
</head>
<body>
    <img src="https://git-scm.com/images/logos/downloads/Git-Logo-1788C.png" alt="Git Logo" class="logo">
    <h1>¡Hola Mundo DevOps!</h1>
    <p>Servidor Apache funcionando correctamente</p>
    <script>
	document.write("Hora del servidor: " + new Date().toLocaleString());
    </script>
    <p>🛠️ Próximos pasos: Configurar HTTPS y un reverse proxy</p>
</body>
</html>
EOF

# Permissions
sudo chown www-data:www-data /var/www/html/index.html
sudo chmod 644 /var/www/html/index.html

echo "Deployment completed."
