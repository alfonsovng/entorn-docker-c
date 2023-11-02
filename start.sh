#!/bin/bash
CURRENT_UID=$(id -u)
CURRENT_GID=$(id -g)
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
UNAME="user"

docker build \
    --build-arg UID=$CURRENT_UID \
    --build-arg GID=$CURRENT_GID \
    --build-arg USER=$UNAME \
    --tag my_gcc \
    $SCRIPT_DIR

docker run -it --rm \
    --name compilador-gcc \
    --hostname GCC \
    --volume ./src:/home/$UNAME \
    --workdir /home/$UNAME \
    --user $(id -u):$(id -g) \
    my_gcc