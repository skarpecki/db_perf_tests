FROM postgres:14.0

ENV POSTGRES_PASSWORD='Pa$$w0rd123'

RUN apt-get update \
&& apt-get install -y \
time \
vim

COPY ./dane/ /dane/
COPY ./skrypty/ /skrypty/