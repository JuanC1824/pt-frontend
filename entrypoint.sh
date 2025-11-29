#!/bin/sh
set -e

echo "🚀 Iniciando contenedor Frontend..."

# Revisar si la variable BACKEND_URL llegó
if [ -z "$BACKEND_URL" ]; then
  echo "❌ ERROR: BACKEND_URL no está definido en Environment Variables de Render"
  exit 1
fi

echo "🔧 Reemplazando __API_URL__ con $BACKEND_URL"
sed -i "s|__API_URL__|${BACKEND_URL}|g" /usr/share/nginx/html/assets/environment.js

echo "✅ Reemplazo completado. Mostrando environment.js final:"
cat /usr/share/nginx/html/assets/environment.js

echo "🌐 Iniciando Nginx..."
nginx -g 'daemon off;'
