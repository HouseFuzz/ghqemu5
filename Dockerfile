FROM ubuntu

# Install dependencies
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list
RUN apt-get update
RUN apt-get build-dep -y qemu
RUN apt-get install -y python3-dev python3-pip
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10
