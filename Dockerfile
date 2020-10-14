FROM ubuntu:20.04

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
#ENV LC_ALL en_US.UTF-8

ENV PROJECT_DIR /home/arvore
WORKDIR  /home/arvore/
ADD . /home/arvore

#########
# BASE
#########
RUN apt-get update -qq && apt-get install -qq -y --no-install-recommends \
            curl \
            git \ 
            build-essential \
            autoconf \
            m4 \
            libncurses5-dev \
            libwxgtk3.0-gtk3-dev \
            libgl1-mesa-dev \
            libglu1-mesa-dev \
            libpng-dev \
            libssh-dev \
            unixodbc-dev \
            xsltproc \
            fop \
            libxml2-utils \
            libncurses-dev openjdk-11-jdk \
            unzip

#########
# ASDF
#########
ENV ASDF_DIR /usr/local/asdf
RUN git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch v0.8.0
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN source $ASDF_DIR/asdf.sh \
    && asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git \
    && asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git \
    && asdf plugin-add rust https://github.com/code-lever/asdf-rust.git \
    && asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
RUN source $ASDF_DIR/asdf.sh && cd ${PROJECT_DIR} && asdf install




# install runtimes

#

#########
# MYSQL
#########

# # Phoenix Installation
# RUN apt-get update && apt-get install -y wget curl postgresql postgresql-contrib libpq-dev bzip2 mysql-client libmysqlclient-dev && \
# rm -rf /var/lib/apt/lists/* && \
# apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
# dpkg -i erlang-solutions_1.0_all.deb && rm -rf  https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
# RUN apt-get update && apt-get install -y esl-erlang elixir git-core  && \
# rm -rf /var/lib/apt/lists/* && \ls

# apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# #

# # NODEJS
# # Replace shell with bash so we can source files
# RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# ENV NVM_DIR /usr/local/nvm
# ENV NODE_VERSION 7.9.0

# RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash \
#   && source $NVM_DIR/nvm.sh \
#   && nvm install $NODE_VERSION \
#   && nvm alias default $NODE_VERSION \
#   && nvm use default

# ENV NODE_PATH $NVM_DIR/$NODE_VERSION/lib/node_modules
# ENV PATH      $NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH

# RUN locale-gen en_US.UTF-8
# ENV LANG en_US.UTF-8
# ENV LANGUAGE en_US:en
# ENV LC_ALL en_US.UTF-8
# ENV MIX_ENV=prod
# #
# #

# # App Installation
# RUN mix local.hex --force
# WORKDIR /home/app/
# ADD . /home/app
# ADD docker/prod.exs /home/app/config/prod.exs
# ADD docker/dev.exs /home/app/config/dev.exs
# ADD docker/prod.secret.exs /home/app/config/prod.secret.exs
# #

# # Use baseimage-docker's init system.
# # CMD ["/sbin/my_init"]

# # ...put your own build instructions here...

# # Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# EXPOSE 5000
# CMD mix phoenix.server
