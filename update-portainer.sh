#!/bin/bash

# Nombre del contenedor de Portainer
CONTAINER_NAME="portainer"

# Ruta donde se almacenan los datos de Portainer
DATA_PATH="portainer_data"

# Verificar si Docker está instalado
if ! [ -x "$(command -v docker)" ]; then
  echo "Error: Docker no está instalado."
  exit 1
fi

# Descargar la última versión de Portainer
echo "Descargando la última versión de Portainer..."
docker pull portainer/portainer-ce:latest

# Detener y eliminar el contenedor anterior
echo "Deteniendo el contenedor de Portainer..."
docker stop $CONTAINER_NAME

echo "Eliminando el contenedor antiguo..."
docker rm $CONTAINER_NAME

# Crear y ejecutar el nuevo contenedor de Portainer
echo "Iniciando el nuevo contenedor de Portainer..."
docker run -d \
  -p 8000:8000 \
  -p 9443:9443 \
  --name $CONTAINER_NAME \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $DATA_PATH:/data \
  portainer/portainer-ce:latest

# Verificar el estado del nuevo contenedor
echo "Verificando el estado del nuevo contenedor..."
docker ps | grep $CONTAINER_NAME

echo "Actualización de Portainer completada."