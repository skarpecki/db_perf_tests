FROM store/oracle/database-enterprise:12.2.0.1

USER root

RUN yum update -y 
RUN yum install time -y 
RUN yum install vim -y


COPY --chown=oracle:oinstall ./dane/ /dane
COPY --chown=oracle:oinstall ./skrypty/ /skrypty

USER oracle