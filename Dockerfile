# PgFuse DockerFile

FROM ubuntu:14.04

RUN apt-get update
RUN apt-get -y --force-yes install make pkg-config g++ wget unzip build-essential libpq-dev libfuse-dev

RUN wget https://github.com/andreasbaumann/pgfuse/archive/master.zip
RUN unzip master.zip

WORKDIR pgfuse-master

RUN make
