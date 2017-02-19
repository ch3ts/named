FROM debian:jessie
MAINTAINER Ulrich Etile <chets@dotbsd-fr.org>

# ---------------------------------------------------
# Variables
# ---------------------------------------------------
ENV DEBIAN_FRONTEND = noninteractive

# ---------------------------------------------------
# Installation
# ---------------------------------------------------
RUN apt-get update && apt-get -y install wget build-essential openssl libssl-dev libdb5.3-dev libterm-readline-gnu-perl


WORKDIR /data

CMD [ "true" ]
