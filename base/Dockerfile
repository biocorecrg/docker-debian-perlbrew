FROM debian:trixie

ARG PERLBREW_ROOT=/usr/local/perl
ARG PERL_VERSION=5.42.0
# Enable perl build options. Example: --build-arg PERL_BUILD="--thread --debug"
ARG PERL_BUILD=--thread

# Base Perl and builddep
RUN set -x; \
  apt-get update && apt-get upgrade -y; \
  apt-get install -y perl bzip2 zip curl \
  build-essential procps
#RUN apt-get build-dep perl

RUN mkdir -p $PERLBREW_ROOT

RUN bash -c '\curl -L https://install.perlbrew.pl | bash'

ENV PATH $PERLBREW_ROOT/bin:$PATH
ENV PERLBREW_PATH $PERLBREW_ROOT/bin

RUN apt install -y libdevel-patchperl-perl
RUN perlbrew install-patchperl
RUN perlbrew --notest install $PERL_BUILD perl-$PERL_VERSION
RUN perlbrew install-cpanm
RUN bash -c 'source $PERLBREW_ROOT/etc/bashrc'

ENV PERLBREW_ROOT $PERLBREW_ROOT
ENV PATH $PERLBREW_ROOT/perls/perl-$PERL_VERSION/bin:$PATH
ENV PERLBREW_PERL perl-$PERL_VERSION
ENV PERLBREW_MANPATH $PERLBREW_ROOT/perls/perl-$PERL_VERSION/man
ENV PERLBREW_SKIP_INIT 1

RUN ln -s $PERLBREW_ROOT/perls/perl-$PERL_VERSION/bin/perl /usr/local/bin/perl

# Add HARICA certificates
ADD https://repo.harica.gr/certs/HARICA-TLS-Root-2021-ECC.pem /usr/local/share/ca-certificates/HARICA_TLS_ECC_Root_CA_2021.crt
ADD https://repo.harica.gr/certs/HARICA-TLS-Root-2021-RSA.pem /usr/local/share/ca-certificates/HARICA_TLS_RSA_Root_CA_2021.crt
RUN update-ca-certificates

# Clean cache
RUN apt-get clean
RUN set -x; rm -rf /var/lib/apt/lists/*

# Workdir place
RUN mkdir -p /project
WORKDIR /project

#ENTRYPOINT ["./entrypoint.sh"]

