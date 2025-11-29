#!/bin/sh
sed -i "s|__API_URL__|${BACKEND_URL}|g" /usr/share/nginx/html/browser/assets/environment.js
nginx -g 'daemon off;'
