FROM garywu/base


# for development
RUN \
  apt-get clean && apt-get update && \
  apt-get -y install sudo \
  make g++ python \
  curl vim unzip bzip2 \
  git

# for xwindow
RUN apt-get clean && apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends ubuntu-desktop && \
    apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus
RUN apt-get install -y roxterm
RUN apt-get install -y tightvncserver autocutsel
RUN apt-get install -y locales && locale-gen en_US.UTF-8 && locale-gen zh_TW.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# for service management
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# for ssh
RUN apt-get install -y openssh-server net-tools
RUN mkdir -p /var/run/sshd

# compilers
RUN apt-get -y install build-essential
# opencv
RUN apt-get -y install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev


ARG USER
# add user
RUN useradd -ms /bin/bash ${USER} && \
  echo "${USER}:${USER}" | chpasswd && adduser ${USER} sudo


# for roxterm
COPY roxterm.desktop /home/${USER}/Desktop/roxterm.desktop
# for vncserver
RUN mkdir /home/${USER}/.vnc
COPY xstartup /home/${USER}/.vnc/xstartup
COPY passwd /home/${USER}/.vnc/passwd
RUN chown -R ${USER}:${USER} /home/${USER} && \
  chmod 600 /home/${USER}/.vnc/passwd


USER ${USER}
ENV USER=${USER}

# install nvm
RUN curl -s -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | /bin/bash
RUN echo "[ -f "/tmp/init" ] && source /tmp/init" >> ~/.bashrc

USER root
ENV USER=root
CMD ["/usr/bin/supervisord"]

EXPOSE 5901 22
