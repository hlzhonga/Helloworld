FROM tomcat:latest
MAINTAINER xieshengxuan
LABEL function=testpipepline
LABEL  VERSION=1.0
ADD target/test2019.war /data/
COPY README.md  /data/
EXPOSE 8080
RUN cp /data/test2019.war  /usr/local/tomcat/webapps/
VOLUME /data
WORKDIR  /usr/local/tomcat/
ARG JAVA_DIR
STOPSIGNAL 9
ENV JAVA_PATH=$JAVA_DIR
EXPOSE 8080
CMD ["/bin/bash","-c","./bin/startup.sh && sleep 3600"]