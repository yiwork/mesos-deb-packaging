FROM ubuntu:focal

ENV DEBIAN_FRONTEND="noninteractive"

COPY . /app

WORKDIR /app

# python3-distutils needed to run get-pip.py script
RUN apt-get update && \
    apt-get upgrade --yes && \
    apt-get install --yes \
      apt-transport-https \
      apt-utils       \
      build-essential \
      ca-certificates \
      default-jdk   \
      autoconf      \
      libtool       \
      libsasl2-dev  \
      libsasl2-modules \
      maven            \
      libapr1-dev      \
      libsvn-dev       \
      zlib1g-dev       \
      iputils-ping     \
      curl          \
      git           \
      gnupg         \
      jq            \
      python2.7     \
      python2.7-dev \
      ruby        \
      ruby-dev    \
      automake    \
      git         \
      make        \
      libssl-dev  \
      libcurl4    \
      libcurl4-gnutls-dev \
      libcurl4-nss-dev    \
      libtool     \
      shellcheck  \
      software-properties-common \
      ssh         \
      sudo        \
      vim         \
      wget        \
      zip      && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python2.7 /app/get-pip.py    && \
    pip install six virtualenv   && \
    gem install fpm   \
    apt-get clean &&  \
    apt-get autoremove --yes

RUN apt-get install -y lib/app/build_mesos
