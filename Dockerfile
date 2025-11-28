# STAGE 1: Build Angular app
FROM node:20 AS build

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# STAGE 2: Serve with NGINX
FROM nginx:alpine

# Copiar el build final (browser)
COPY --from=build /app/dist/frontend/browser /usr/share/nginx/html

# Copiar el environment.js al contenedor (MUY IMPORTANTE)
COPY --from=build /app/src/assets/environment.js /usr/share/nginx/html/assets/environment.js

# Copiar NGINX config
COPY default.conf /etc/nginx/conf.d/default.conf

# Script de variables
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80
CMD ["/entrypoint.sh"]
