#!/bin/bash
if ! [ -x "$(command -v curl)" ]; then
  echo 'Error: curl is not installed.' >&2
  sudo apt install curl
fi

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  sudo apt install git
fi

if ! [ -x "$(command -v docker)" ]; then
  echo 'Error: docker is not installed.' >&2
  curl -fsSL get.docker.com -o /root/get-docker.sh
  sudo sh /root/get-docker.sh
  sudo usermod -aG docker $(whoami)
fi

if ! [ -x "$(command -v docker-compose)" ]; then
  echo 'Error: docker-compose is not installed.' >&2
  sudo curl -L https://github.com/docker/compose/releases/download/1.19.0-rc3/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

git clone https://github.com/BradooTech/odoo-docker -b 11.0 --depth=1
cd odoo-docker
./clone.sh
docker-compose up -d
