FROM ubuntu

USER root
ARG MIRROR
RUN sed -i "s/http:\/\/archive\.ubuntu\.com/http:\/\/${MIRROR}/g" /etc/apt/sources.list

RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && apt-get install -y --no-install-recommends ubuntu-desktop && \
    apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal && \
    apt-get install -y tightvncserver

ARG USER
# add user
RUN useradd -ms /bin/bash ${USER} && \
  echo "${USER}:${USER}" | chpasswd && adduser ${USER} sudo

RUN mkdir /home/${USER}/.vnc
ADD xstartup /home/${USER}/.vnc/xstartup
ADD passwd /home/${USER}/.vnc/passwd
RUN chown -R ${USER}:${USER} /home/${USER} && \
  chmod 666 /home/${USER}/.vnc/passwd


USER ${USER}
ENV USER=${USER}

CMD /usr/bin/vncserver :1 -geometry 1280x800 -depth 24 && tail -f /home/${USER}/.vnc/*:1.log

EXPOSE 5901
