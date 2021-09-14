FROM mcr.microsoft.com/mssql/server:2019-CU10-ubuntu-20.04

ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=Euorpe/Warsaw
ENV ACCEPT_EULA='Y'
ENV SA_PASSWORD='Pa$$w0rd123'
ENV MSSQL_PID='Developer'
ENV MSSQL_TCP_PORT=1433

USER root

RUN apt-get update \
&& apt-get install -y \
time \
vim

COPY ./dane/ /dane
COPY ./skrypty/ /skrypty
