# #!/bin/bash

image=stevenaldinger/redis-commander
version=1.0.0

echo
echo 'Setting project root...'

echo 'project_root=$(cd -P -- "$(dirname -- "$0")" && pwd -P)'
project_root=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

echo
echo "project_root=${project_root}"

build-redis-commander () {
  echo
  echo "rm -rf \"${project_root}/tmp\""
  rm -rf "${project_root}/tmp"

  echo
  echo "mkdir -p \"${project_root}/tmp\""
  mkdir -p "${project_root}/tmp"

  echo
  echo "docker run --rm --name download-redis-commander \\
    -v \"${project_root}/tmp\":/var/persistence \\
    mhart/alpine-node sh -c 'npm install -g redis-commander && mv /usr/lib/node_modules/redis-commander /var/persistence/redis-commander'"

  docker run --rm --name download-redis-commander \
    -v "${project_root}/tmp":/var/persistence \
    mhart/alpine-node sh -c 'npm install -g redis-commander && mv /usr/lib/node_modules/redis-commander /var/persistence/redis-commander'

  [ ! -d "${project_root}/tmp/redis-commander" ] && \
  echo "[ERROR]: ${project_root}/tmp/redis-commander does not exist. Not building image." || \
  docker build -t "${image}:latest" "${project_root}" && \
  docker tag "${image}:latest" "${image}:${version}"

  echo
  echo "rm -rf \"${project_root}/tmp\""
  rm -rf "${project_root}/tmp"
}

push-redis-commander () {
  docker push "${image}:latest"
  docker push  "${image}:${version}"
}
