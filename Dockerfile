FROM ubuntu:20.04

ENV LANG C.UTF-8
ENV LANGUAGE C:en
ENV LC_ALL C

#########
# BASE
#########
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq 
RUN apt-get install -qq -y --no-install-recommends \
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
            libncurses-dev \ 
            openjdk-11-jdk \
            unzip \
            dirmngr \
            gpg 

            

#########
# ASDF
#########
ENV ASDF_DIR /usr/local/asdf
RUN git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch v0.8.0
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN echo "source $ASDF_DIR/asdf.sh" >> ~/.bashrc

# --------------------------
# install plugins
# --------------------------
RUN source $ASDF_DIR/asdf.sh \
    && asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
RUN source $ASDF_DIR/asdf.sh \
    && asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git 
RUN source $ASDF_DIR/asdf.sh \
    && asdf plugin-add rust https://github.com/code-lever/asdf-rust.git 
RUN source $ASDF_DIR/asdf.sh \
    && asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

# --------------------------
# install runtime versions
# --------------------------
# erlang 21.3.8.6
# elixir 1.8.2-otp-21
# rust 1.43.1
# yarn 1.7.0
# nodejs 10.15.3
# -------------------------
RUN source $ASDF_DIR/asdf.sh \
    && export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac" \
    && asdf install erlang 21.3.8.6 \
    && asdf install elixir 1.8.2-otp-21 \
    && asdf install rust 1.43.1 \
    && bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring' \
    && asdf install nodejs 10.15.3 

# --------------------------
# install runtime versions
# --------------------------
# erlang 21.3.8.6
# elixir 1.8.2-otp-21
# rust 1.43.1
# yarn 1.7.0
# nodejs 10.15.3
# -------------------------


#########
# MYSQL
#########

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
