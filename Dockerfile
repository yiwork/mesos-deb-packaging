FROM ubuntu:focal

ENV DEBIAN_FRONTEND="noninteractive" \
    PYTHON="/usr/bin/python2.7"

COPY . /app

WORKDIR /app

# python3-distutils needed to run get-pip.py script
RUN apt-get update && \
    apt-get upgrade --yes && \
    sudo apt-get install --yes \
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

RUN wget https://apache.osuosl.org/mesos/1.10.0/mesos-1.10.0.tar.gz ./ && \
    tar xvf ./mesos-1.10.0.tar.gz  && \
    mv mesos-1.10.0 mesos-repo    && \
    patch < Makefile.patch        && \
    cat log_linux.path >> mesos-repo/3rdparty/grpc-1.10.0.patch  && \
    cd mesos-repo && \
    ./bootstrap   && \
    mkdir build   && \
    cd build      && \
    ../configure  && \
    make

