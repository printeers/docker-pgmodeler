FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        build-essential \
        libpq-dev \
        libpq5 \
        libqt6svg6-dev \
        libxml2 \
        libxml2-dev \
        pkg-config \
        pkg-config\
        libgl1-mesa-dev \
        qt6-base-dev \
        wget \
        libxext-dev\
        xml2 \
    && rm -rf /var/lib/apt/lists/*

ENV PGM_VERSION "1.0.2"

RUN mkdir -p /usr/local/src/pgmodeler
WORKDIR "/usr/local/src/pgmodeler"
RUN wget https://github.com/pgmodeler/pgmodeler/archive/v$PGM_VERSION.tar.gz && \
        tar -xzvf v$PGM_VERSION.tar.gz && \
        rm -f v$PGM_VERSION.tar.gz

RUN cd /usr/local/src/pgmodeler/pgmodeler-$PGM_VERSION/ && \
        qmake6 pgmodeler.pro && \
        make -j 10 && \
        make install

# ENV QT_QPA_PLATFORM=offscreen

# ADD config /root/.config/pgmodeler/
