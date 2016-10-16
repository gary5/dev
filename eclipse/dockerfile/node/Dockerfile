FROM garywu/eclipse-base

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

USER user
WORKDIR /home/user
ENV HOME=/home/user

# install nvm
ENV NVM_DIR ${HOME}/.nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash && \
  . ${NVM_DIR}/nvm.sh && \
  nvm install v4.5.0 && \
  nvm install v5.12.0 && \
  nvm install v6.6.0

RUN echo "source /tmp/init" >> ~/.bashrc
