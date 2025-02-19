#!/bin/bash

set -e

# Source environment variables from .env if available.
if [ -f .env ]; then
  echo "Sourcing environment variables from .env..."
  set -o allexport
  source .env
  set +o allexport
else
  echo "Error: .env file not found. Exiting."
  exit 1
fi

# Construct the image tag from environment variables.
IMAGE_TAG="${DOCKER_HUB_NAME}/${DOCKER_NAME}:${JENKINS_VERSION}"
echo "Building Docker image: ${IMAGE_TAG}..."

# Build the Docker image.
docker build -t "${IMAGE_TAG}" .

echo "Docker image built successfully."

# Start docker-compose in detached mode.
echo "Starting docker-compose..."
docker-compose up -d

echo "Services are up and running using image ${IMAGE_TAG}."
