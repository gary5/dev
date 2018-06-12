FROM garywu/base


# for development
RUN \
  apt-get clean && apt-get update && \
  apt-get -y install sudo \
  make g++ python \
  curl vim unzip bzip2

# install ssh
RUN \
    apt-get clean && apt-get update && \
    apt-get install -y openssh-server net-tools
RUN mkdir -p /var/run/sshd

# install xwindow
RUN \
    apt-get clean && apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends ubuntu-desktop && \
    apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal fonts-noto
RUN apt-get install -y roxterm
RUN apt-get install -y locales && locale-gen en_US.UTF-8 && locale-gen zh_TW.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# install chrome
RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt-get update && \
  apt-get install -y google-chrome-stable

# install vncserver
RUN \
    apt-get clean && apt-get update && \
    apt-get install -y vnc4server autocutsel

# compilers
RUN apt-get -y install build-essential
# opencv: required
RUN \
  apt-get clean && apt-get update && \
  apt-get -y install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
  ocl-icd-libopencl1 opencl-headers libv4l-dev libopencv-dev
# python for opencv
RUN apt-get -y install python-pip && pip install --upgrade pip


ARG USER
# add user
RUN useradd -ms /bin/bash ${USER} && \
  echo "${USER}:${USER}" | chpasswd && adduser ${USER} sudo

# opencv: env setup
RUN pip install virtualenv virtualenvwrapper
RUN rm -rf ~/.cache/pip
# for roxterm
COPY roxterm.desktop /home/${USER}/Desktop/roxterm.desktop

# for vncserver
RUN mkdir /home/${USER}/.vnc
COPY xstartup /home/${USER}/.vnc/xstartup
COPY passwd /home/${USER}/.vnc/passwd
RUN chown -R ${USER}:${USER} /home/${USER} && \
  chmod 755 /home/${USER}/.vnc/xstartup && \
  chmod 600 /home/${USER}/.vnc/passwd


# install service management
RUN \
    apt-get clean && apt-get update && \
    apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# intall git
RUN \
    apt-get clean && apt-get update && \
    apt-get install -y git

# install atom
RUN apt-get install apt-transport-https
RUN curl -sL https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
RUN echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list
RUN \
    apt-get clean && apt-get update && \
    apt-get install -y atom

# clear cache
RUN rm -rf /var/lib/apt/lists/*

# Fix GUI app issue
RUN cp /usr/lib/x86_64-linux-gnu/libxcb.so.1 /usr/lib/x86_64-linux-gnu/libxcb.so.1.bak
RUN sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1

USER ${USER}
ENV USER=${USER}

# opencv: virtualenv and virtualenvwrapper
RUN echo "export WORKON_HOME=\$HOME/.virtualenvs\n\
source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc

# install nvm
RUN curl -s -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | /bin/bash; /bin/bash -i -c 'nvm install v10.3.0'
RUN echo "[ -f "/tmp/docker_init_script" ] && source /tmp/docker_init_script" >> ~/.bashrc

# install yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | /bin/bash -i

# install atom packages
RUN apm install language-babel
RUN apm install atom-ternjs
RUN apm install linter linter-ui-default intentions busy-signal linter-eslint
RUN apm install file-icons
RUN apm install pretty-json
RUN apm install termination

USER root
ENV USER=root
CMD ["/usr/bin/supervisord"]

EXPOSE 5901 22
