FROM biocorecrg/debian-perlbrew

# File Author / Maintainer
MAINTAINER Toni Hermoso Pulido <toni.hermoso@crg.eu>
MAINTAINER Luca Cozzuto <lucacozzuto@gmail.com> 

ARG PYENV_ROOT=/usr/local/python
ARG PYTHON_VERSION=2.7.13

ENV PYENV_ROOT $PYENV_ROOT

RUN set -x; apt-get update; apt-get upgrade; apt-get install -y git libreadline-dev sqlite3 libsqlite3-dev libssl-dev zlib1g-dev libbz2-dev tk-dev

RUN bash -c 'curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash'

ENV PATH $PYENV_ROOT/bin:$PATH
ENV PYTHON_VERSION $PYTHON_VERSION

RUN pyenv install $PYTHON_VERSION

ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/versions/$PYTHON_VERSION/bin:$PATH"

# Clean cache
RUN apt-get clean
RUN set -x; rm -rf /var/lib/apt/lists/*


