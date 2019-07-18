FROM biocorecrg/debian-perlbrew-pyenv:buster

# File Author / Maintainer
MAINTAINER Toni Hermoso Pulido <toni.hermoso@crg.eu>
MAINTAINER Luca Cozzuto <lucacozzuto@gmail.com> 

ARG JAVA_VERSION=11
ARG MAVEN_VERSION=3.6.1

ENV JAVA_HOME /usr/lib/jvm/java-${JAVA_VERSION}-openjdk-amd64

# Install Redis
RUN set -x; apt-get update; apt-get -y upgrade; 
# Install Java
RUN set -x; apt-get -y install openjdk-$JAVA_VERSION-jdk
RUN set -x; update-java-alternatives -s java-1.$JAVA_VERSION.0-openjdk-amd64

# Install maven

RUN cd /usr/local; curl --fail --silent --show-error --location --remote-name http://apache.rediris.es//maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz

RUN cd /usr/local; tar zxf apache-maven-$MAVEN_VERSION-bin.tar.gz
RUN cd /usr/local; rm apache-maven-$MAVEN_VERSION-bin.tar.gz
RUN cd /usr/local; ln -s /usr/local/apache-maven-$MAVEN_VERSION/bin/mvn /usr/local/bin/mvn

# Clean cache
RUN apt-get clean
RUN set -x; rm -rf /var/lib/apt/lists/*

