FROM phusion/baseimage:0.9.15
MAINTAINER dcflachs <dcflachs@gmail.com>

########################################
##        ENVIRONMENTAL CONFIG        ##
########################################
# Set correct environment variables
ENV HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"

ENV SCM_VERSION 1.44
ENV JAVA_VERSION 7
ENV SCM_PKG_URL https://maven.scm-manager.org/nexus/content/repositories/releases/sonia/scm/scm-server/${SCM_VERSION}/scm-server-${SCM_VERSION}-app.tar.gz
ENV SCM_HOME /var/lib/scm

ENV JAVA_HOME /usr/lib/jvm/java-${JAVA_VERSION}-openjdk-amd64

# Use baseimage-docker's init system
#CMD ["/sbin/my_init"]

# Configure user nobody to match unRAID's settings
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody
RUN usermod -d /home nobody
RUN chown -R nobody:users /home

#Install Java, curl and mercurial
RUN apt-get update && apt-get install -qq -y \
    openjdk-${JAVA_VERSION}-jre \
    curl \
    mercurial \
    && apt-get autoremove \
    && apt-get clean
    
#Install scm-server
RUN curl -Lks "$SCM_PKG_URL" -o /root/scm-server.tar.gz \
    && /usr/sbin/useradd --create-home --home-dir /opt/scm-server --shell /bin/bash scm \
    && tar zxf /root/scm-server.tar.gz --strip=1 -C /opt/scm-server \
    && rm -f /root/scm-server.tar.gz \
    && chown -R nobody:users /opt/scm-server
    
#Create Data Directories
RUN mkdir -p /var/lib/scm \
    && chown nobody:users /var/lib/scm

WORKDIR /var/lib/scm
USER nobody

VOLUME /var/lib/scm
EXPOSE 8080

CMD ["/opt/scm-server/bin/scm-server"]