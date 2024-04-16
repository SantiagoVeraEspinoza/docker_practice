# Usa una imagen base de Ubuntu
FROM ubuntu:20.04

# Evita preguntas al instalar paquetes
ARG DEBIAN FRONTEND-noninteractive

#  Instala curl y otros paquetes necesarios, luego limpia el cache
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Define el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos del paquete y el archivo de bloqueo de paquetes
COPY package*.json ./

# Instala las dependencias del proyecto
RUN npm install

# Copia el resto de los archivos del proyecto
COPY . .

# Expone el puerto en el que se ejecutará la aplicación
EXPOSE 3000

# Comando para ejecutar la aplicación
CMD ["node", "server.js"]