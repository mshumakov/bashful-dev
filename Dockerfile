FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y \
        make \
        wget \
    && wget https://github.com/wagoodman/bashful/releases/download/v0.1.1/bashful_0.1.1_linux_amd64.deb \
    && apt-get install -y ./bashful_0.1.1_linux_amd64.deb --no-install-recommends \
    && rm -fr /var/lib/apt/lists/* \
    && bashful -v