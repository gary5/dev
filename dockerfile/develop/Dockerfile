FROM garywu/base

USER root

RUN \
  apt-get update && \
  apt-get install -y ca-certificates && \
  apt-get -y upgrade && \
  rm -rf /var/lib/apt/lists/*

RUN \
  apt-get update && \
  apt-get -y install sudo \
  make g++ python \
  curl vim unzip bzip2 \
  git


ARG USER
# add user
RUN useradd -ms /bin/bash ${USER} && \
  echo "${USER}:${USER}" | chpasswd && adduser ${USER} sudo

USER ${USER}
ENV USER=${USER}

WORKDIR /home/${USER}
ENV HOME=/home/${USER}

CMD /bin/bash
