#!/bin/bash

PUBLIC_IP=$(terraform output -raw web_server_public_ip)
echo "Checking Nginx server at http://44.203.67.246"

# Wait a moment for the server to be ready
sleep 10

# Check if the server responds
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://44.203.67.246)

if [ "$HTTP_STATUS" -eq 200 ]; then
  echo "Success! Nginx server is running."
  exit 0
else
  echo "Error: Nginx server is not responding correctly. HTTP status: $HTTP_STATUS"
  exit 1
fi
