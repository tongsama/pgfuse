# PgFuse DockerFile

FROM ubuntu:14.04

RUN apt-get update
RUN apt-get -y --force-yes install make g++ build-essential libpq-dev libfuse-dev

RUN make
