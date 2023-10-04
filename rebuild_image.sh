#!/bin/bash

set -e

IMAGE="jmanzur/dev-container:latest"
IMAGE_NAME="jmanzur-dev-container"

image_build() {
  echo "Building image: $IMAGE"
  docker build -t $IMAGE .
}

echo "Stopping and removing container: $IMAGE"
echo ""
if docker image ls --filter 'reference='$IMAGE'' --format '{{.Repository}}'; then
    IMAGE_ID=$( docker image ls --filter 'reference='$IMAGE'' --format '{{.ID}}')
    docker rmi "$IMAGE_ID" -f
    if [ $? -eq 0 ]; then
        echo "Image removed successfully."
        image_build
    else
        echo "Failed to remove the image."
    fi
else
    echo "The image '$IMAGE' does not exist."
    image_build
fi

# Check the exit status of the previous command
if [ $? -eq 0 ]; then
  echo ""
  sudo docker run --name $IMAGE_NAME --rm -ti $IMAGE /bin/bash
  exit 0
else
  echo ""
  echo "Error: The process was not successful"
  echo ""
  exit 1
fi