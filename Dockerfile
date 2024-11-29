# syntax=docker/dockerfile:1.2

# Parameters
# This could be overridden when building 

ARG STATAVERSION=18
ARG STATATAG=2024-10-16
ARG STATAHUBID=dataeditors


## ================== Define base images =====================

# define the source for Stata
FROM ${STATAHUBID}/stata${STATAVERSION}:${STATATAG} as stata

USER root

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
         curl \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

# Add Julia
# This happens in user-space
USER statauser
WORKDIR /home/statauser

ARG JULIAVER=1.5.3

RUN  curl -fsSL https://install.julialang.org | sh -s -- -y &&\
     /home/statauser/.juliaup/bin/juliaup add $JULIAVER &&\
     /home/statauser/.juliaup/bin/juliaup default $JULIAVER

VOLUME "/project"


