FROM mysql:8.0.25

ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=Euorpe/Warsaw
ENV MYSQL_ROOT_PASSWORD='Pa$$w0rd123'

USER root
EXPOSE 3306

COPY ./skrypty/ /scripts
COPY ./dane/ /dane
RUN apt-get update \
&& apt-get install -y \
time \
vim