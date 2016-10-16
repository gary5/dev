FROM ubuntu

USER root
ARG MIRROR
RUN sed -i "s/http:\/\/archive\.ubuntu\.com/http:\/\/${MIRROR}/g" /etc/apt/sources.list
