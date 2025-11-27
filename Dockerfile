# STAGE 1: Build Angular app
FROM node:20 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build   # Angular 15+ toma el environment automáticamente

# STAGE 2: Serve with NGINX
FROM nginx:alpine

# Copiar la build de Angular
COPY --from=build /app/dist/frontend /usr/share/nginx/html

# Copiar environment.js después para asegurarse que la carpeta exista
COPY src/assets/environment.js /usr/share/nginx/html/assets/environment.js

# Copiar configuración NGINX
COPY default.conf /etc/nginx/conf.d/default.conf

# Copiar el entrypoint para reemplazo de environment
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

# Ejecutar el entrypoint
CMD ["/entrypoint.sh"]
