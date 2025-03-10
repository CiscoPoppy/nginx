#!/bin/bash
# Script to install and configure Nginx locally

echo "=== Starting Nginx Installation ==="

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Install Nginx
echo "Installing Nginx..."
sudo apt-get install -y nginx

# Start Nginx and enable it to start on boot
echo "Starting Nginx service..."
sudo systemctl start nginx
sudo systemctl enable nginx

# Create a custom index page
echo "Creating custom index page..."
echo "<h1>Nginx Deployed with Jenkins!</h1>" >> /var/www/html/index.nginx-debian.html

# Verify Nginx is running
echo "Verifying Nginx status..."
if sudo systemctl is-active --quiet nginx; then
  echo "=== SUCCESS: Nginx is running! ==="
  echo "You can access it at: http://$(hostname -I)"
  exit 0
else
  echo "=== ERROR: Nginx failed to start ==="
  exit 1
fi
