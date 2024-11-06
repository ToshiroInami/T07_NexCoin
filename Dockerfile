# Etapa 1: Compilar la aplicación
FROM node:18 AS build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar package.json y package-lock.json para instalar dependencias
COPY package.json package-lock.json ./

# Instalar dependencias
RUN npm install

# Copiar todos los archivos del proyecto
COPY . .

# Compilar la aplicación para producción
RUN npm run build --prod

# Etapa 2: Servir la aplicación con un servidor web ligero
FROM nginx:alpine

# Copiar los archivos compilados de la etapa anterior a la carpeta predeterminada de Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Exponer el puerto en el que correrá Nginx
EXPOSE 80

# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]ss