FROM ubuntu:focal

ENV DEBIAN_FRONTEND="noninteractive" \
    PYTHON="/usr/bin/python2.7"      \
    MESOS_VERSION="1.10.0"

COPY . /app

WORKDIR /app

# python3-distutils needed to run get-pip.py script
RUN apt-get update && \
    sudo apt-get install --no-install-recommends --yes \
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
      software-properties-common \
      vim         \
      wget        \
      zip      && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python2.7 /app/get-pip.py    && \
    pip install six virtualenv   && \
    gem install fpm   && \
    apt-get clean     && \
    apt-get autoremove --yes     && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://apache.osuosl.org/mesos/$MESOS_VERSION/mesos-${MESOS_VERSION}.tar.gz ./ && \
    tar xvf ./mesos-${MESOS_VERSION}.tar.gz  && \
    mv mesos-${MESOS_VERSION} mesos-repo

CMD ["build_mesos"]

