FROM mysql:8.0.25

ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=Euorpe/Warsaw
ENV MYSQL_ROOT_PASSWORD='Pa$$w0rd123'

USER root

# Modifying my.cnf with /dane/ as secure_file_priv 
COPY my.cnf /etc/mysql/my.cnf
RUN apt-get update \
&& apt-get install -y \
time \
vim

COPY ./dane/ /dane/
COPY ./skrypty/ /skrypty/