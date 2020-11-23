FROM ubuntu:focal

ENV DEBIAN_FRONTEND="noninteractive"

# python3-distutils needed to run get-pip.py script
RUN apt-get update && \
    apt-get upgrade --yes && \
    apt-get install --yes \
      apt-transport-https \
      apt-utils       \
      build-essential \
      ca-certificates \
      cloc        \
      curl        \
      git         \
      gnupg       \
      jq          \
      python3     \
      python3-dev \
      ruby        \
      ruby-dev    \
      autoconf    \
      automake    \
      git         \
      make        \
      libssl-dev  \
      libcurl3    \
      libtool     \
      shellcheck  \
      software-properties-common \
      ssh         \
      sudo        \
      vim         \
      wget        \
      zip      && \
    gem install fpm   \
    apt-get clean &&  \
    apt-get autoremove --yes

