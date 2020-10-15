FROM cimg/elixir:1.8.2-node

ENV LANG C.UTF-8
ENV LANGUAGE C:en
ENV LC_ALL C

#########
# BASE
#########
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq 
RUN apt-get install -qq -y --no-install-recommends \
            mysql-client
