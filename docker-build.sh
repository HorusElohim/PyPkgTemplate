#! /bin/bash

echo -e "* Docker build started"
echo -e "* Detection architecture..."
architecture=$(dpkg --print-architecture)

# AMD64
if [[ $architecture == "amd64" ]]; then
  echo -e "* (amd64)"
  dockerfile=docker/amd64/Dockerfile
fi

# ARM64
if [[ $architecture == "arm64" ]]; then
  echo -e "* (arm64)"
  case $(sudo lshw -short | grep system) in
    *"Raspberry"*)
      echo -e "* * (Raspberry)"
      dockerfile=docker/arm64/raspberry/Dockerfile
      ;;
    *"Jetson Nano"*)
      echo -e "* * (Jetson Nano)"
      dockerfile=docker/arm64/jetsonano/Dockerfile
      ;;
  esac
fi

echo -e "* Dockerfile used: $dockerfile"
docker build -t my_package -f $dockerfile .
