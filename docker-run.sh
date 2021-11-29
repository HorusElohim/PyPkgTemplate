#! /bin/bash

DOCKER_IMAGE_NAME='my_package'

echo -e "* Docker build run"
echo -e "* Detection architecture..."

architecture=$(dpkg --print-architecture)

# AMD64
if [[ $architecture == "amd64" ]]; then
  echo -e "* (amd64)"
  dockercmd="-it --rm --gpus all --network host $DOCKER_IMAGE_NAME $*"
fi

# ARM64
if [[ $architecture == "arm64" ]]; then
  echo -e "* (arm64)"
  case $(sudo lshw -short | grep system) in
    *"Raspberry"*)
      echo -e "* * (Raspberry)"
      dockercmd="-it --rm --network host $DOCKER_IMAGE_NAME $*"
      ;;
    *"Jetson Nano"*)
      echo -e "* * (Jetson Nano)"
      dockercmd="-it --rm --runtime nvidia --network host $DOCKER_IMAGE_NAME $*"
      ;;
  esac
fi

echo "* Running docker with the following cmd: $dockercmd"
docker run $dockercmd
