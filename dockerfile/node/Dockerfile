FROM garywu/develop

# install nvm
ENV NVM_DIR ${HOME}/.nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash && \
  curl -o- -L https://yarnpkg.com/install.sh | bash && \
  . ${NVM_DIR}/nvm.sh && \
  nvm install v4.5.0 && \
  nvm install v5.12.0 && \
  nvm install v6.6.0

RUN echo "source /tmp/init" >> ~/.bashrc

CMD /bin/bash
