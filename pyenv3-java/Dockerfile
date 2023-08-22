FROM biocorecrg/debian-perlbrew-pyenv3:bullseye

# File Author / Maintainer
MAINTAINER Toni Hermoso Pulido <toni.hermoso@crg.eu>
MAINTAINER Luca Cozzuto <lucacozzuto@gmail.com> 

ARG JAVA_VERSION=17
ARG MAVEN_VERSION=3.8.7

# Install Redis
RUN set -x; apt-get update; apt-get -y upgrade; 
# Install Java
RUN set -x; apt-get -y install openjdk-$JAVA_VERSION-jdk
RUN set -x; ARCH=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) && update-java-alternatives -s java-1.$JAVA_VERSION.0-openjdk-${ARCH}

# Set JAVA_HOME -> https://stackoverflow.com/questions/43655291/dynamically-set-java-home-of-docker-container
# https://stackoverflow.com/questions/34911622/dockerfile-set-env-to-result-of-command
RUN bash -l -c 'echo export JAVA_HOME="$(dirname $(dirname $(readlink -f $(type -P java))))"  >> /etc/bash.bashrc'

# Install maven

RUN cd /usr/local; curl --fail --silent --show-error --location --remote-name https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz

RUN cd /usr/local; tar zxf apache-maven-$MAVEN_VERSION-bin.tar.gz
RUN cd /usr/local; rm apache-maven-$MAVEN_VERSION-bin.tar.gz
RUN cd /usr/local; ln -s /usr/local/apache-maven-$MAVEN_VERSION/bin/mvn /usr/local/bin/mvn

# Clean cache
RUN apt-get clean
RUN set -x; rm -rf /var/lib/apt/lists/*

