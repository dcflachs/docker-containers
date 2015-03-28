FROM phusion/baseimage:0.9.15
MAINTAINER dcflachs <dcflachs@gmail.com>

########################################
##        ENVIRONMENTAL CONFIG        ##
########################################
# Set correct environment variables
ENV HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"

ENV SCM_VERSION 1.44
ENV SCM_PKG_URL https://maven.scm-manager.org/nexus/content/repositories/releases/sonia/scm/scm-server/${SCM_VERSION}/scm-server-${SCM_VERSION}-app.tar.gz
ENV SCM_HOME /var/lib/scm

ENV JAVA_HOME /usr/lib/jvm/default-java

# Use baseimage-docker's init system
#CMD ["/sbin/my_init"]

# Configure user nobody to match unRAID's settings
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody
RUN usermod -d /home nobody
RUN chown -R nobody:users /home

RUN apt-get update \
    && apt-get install -qq -y openjdk-7-jre \  
    && apt-get autoremove \
    && apt-get clean
    
RUN apt-get update \
    && apt-get install -qq -y curl mercurial \  
    && curl -Lks "$SCM_PKG_URL" -o /root/scm-server.tar.gz \
    && /usr/sbin/useradd --create-home --home-dir /opt/scm-server --shell /bin/bash scm \
    && tar zxf /root/scm-server.tar.gz --strip=1 -C /opt/scm-server \
    && rm -f /root/scm-server.tar.gz \
    && chown -R scm:scm /opt/scm-server \
    && mkdir -p /var/lib/scm \
    && chown scm:scm /var/lib/scm \
    && apt-get autoremove \
    && apt-get clean


WORKDIR /var/lib/scm
VOLUME /var/lib/scm
EXPOSE 8080
USER scm
CMD ["/opt/scm-server/bin/scm-server"]