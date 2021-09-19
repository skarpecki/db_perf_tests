FROM store/oracle/database-enterprise:12.2.0.1

USER root

RUN yum update -y 
RUN yum install time -y 
RUN yum install vim -y


COPY ./skrypty/ /skrypty
COPY ./dane/ /dane

USER oracle