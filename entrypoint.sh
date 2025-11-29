#!/bin/sh
# Reemplaza __API_URL__ con la variable de entorno BACKEND_URL
sed -i "s|__API_URL__|${BACKEND_URL}|g" /usr/share/nginx/html/assets/environment.js
nginx -g 'daemon off;'
