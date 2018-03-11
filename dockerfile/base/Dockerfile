FROM ubuntu

USER root
ARG MIRROR
RUN sed -i "s/http:\/\/archive\.ubuntu\.com/http:\/\/${MIRROR}/g" /etc/apt/sources.list

RUN \
  apt-get update && apt-get -y dist-upgrade && apt-get autoremove

RUN \
  apt-get install -y ca-certificates && \
  apt-get -y upgrade && \
  rm -rf /var/lib/apt/lists/*
