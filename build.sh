#!/bin/bash

cd $(dirname $0)

if [[ ! $(docker images -q ghqemu5_builder) ]];
then
    docker build -t ghqemu5_builder .
fi

if [[ ! $(docker images -q ghqemu5_builder) ]];
then
    echo "Failed to build ghqemu5_builder image"
    exit 1
fi

docker run --rm -it -v $(pwd):/root ghqemu5_builder \
    /bin/bash -c " \
        cd /root/qemu5 && \
        ./configure --prefix=/root/qemu-user-static --static --disable-system --enable-linux-user && \
        make -j32 && make install && \
        for i in /root/qemu-user-static/bin/*-static; do rm -f \$i; done && \
        for i in /root/qemu-user-static/bin/*; do mv \$i \$i-static; done"
