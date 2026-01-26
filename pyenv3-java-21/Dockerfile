FROM biocorecrg/debian-perlbrew-pyenv3:bookworm

ARG JAVA_VERSION=21
ARG MAVEN_VERSION=3.9.10

RUN set -x; apt-get update; apt-get -y upgrade;
RUN set -x; apt install -y extrepo; extrepo enable zulu-openjdk;
RUN set -x; apt update;
# Install Java
RUN set -x; apt-get -y install zulu$JAVA_VERSION-jdk

# Set JAVA_HOME -> https://stackoverflow.com/questions/43655291/dynamically-set-java-home-of-docker-container
# https://stackoverflow.com/questions/34911622/dockerfile-set-env-to-result-of-command
RUN bash -l -c 'echo export JAVA_HOME="$(dirname $(dirname $(readlink -f $(type -P java))))"  >> /etc/bash.bashrc'

# Install maven

RUN cd /usr/local; curl --fail --silent --show-error --location --remote-name https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz

RUN cd /usr/local; tar zxf apache-maven-$MAVEN_VERSION-bin.tar.gz
RUN cd /usr/local; rm apache-maven-$MAVEN_VERSION-bin.tar.gz
RUN cd /usr/local; ln -s /usr/local/apache-maven-$MAVEN_VERSION/bin/mvn /usr/local/bin/mvn

# HARICA Certs
ENV JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-openjdk-${ARCH}
RUN keytool -importcert -alias harica-ecc -noprompt \
    -file /usr/local/share/ca-certificates/HARICA_TLS_ECC_Root_CA_2021.crt \
    -keystore $JAVA_HOME/lib/security/cacerts \
    -storepass changeit
RUN keytool -importcert -alias harica-rsa -noprompt \
    -file /usr/local/share/ca-certificates/HARICA_TLS_RSA_Root_CA_2021.crt \
    -keystore $JAVA_HOME/lib/security/cacerts \
    -storepass changeit

# Clean cache
RUN apt-get clean
RUN set -x; rm -rf /var/lib/apt/lists/*
