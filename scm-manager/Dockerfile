FROM phusion/baseimage:latest
MAINTAINER dcflachs <dcflachs@gmail.com>

########################################
##        ENVIRONMENTAL CONFIG        ##
########################################
# Set correct environment variables
ENV HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"

ENV SCM_VERSION 1.46
#ENV JAVA_VERSION 8
ENV SCM_PKG_URL https://maven.scm-manager.org/nexus/content/repositories/releases/sonia/scm/scm-server/${SCM_VERSION}/scm-server-${SCM_VERSION}-app.tar.gz
ENV SCM_HOME /var/lib/scm

#ENV JAVA_HOME /usr/lib/jvm/java-${JAVA_VERSION}-openjdk-amd64
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Configure user nobody to match unRAID's settings
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody
RUN usermod -d /home nobody
RUN chown -R nobody:users /home

#Install Java, curl and mercurial
RUN \
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	add-apt-repository -y ppa:webupd8team/java && \
	apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -qq -y \
    oracle-java8-installer \
    curl \
    mercurial \
    && apt-get autoremove \
    && apt-get clean \
	&& rm -rf /var/lib/apt/lists/* 
	&& rm -rf /tmp/* 
	&& rm -rf /var/tmp/* 
	&& rm -rf /var/cache/oracle-jdk8-installer
    
#Install scm-server
RUN curl -Lks "$SCM_PKG_URL" -o /root/scm-server.tar.gz \
    && /usr/sbin/useradd --create-home --home-dir /opt/scm-server --shell /bin/bash scm \
    && tar zxf /root/scm-server.tar.gz --strip=1 -C /opt/scm-server \
    && rm -f /root/scm-server.tar.gz \
    && chown -R nobody:users /opt/scm-server
    
#Create Config Directories
RUN mkdir -p /var/lib/scm-config \
    && mkdir -p /var/lib/scm-config/comfig \
    && mkdir -p /var/lib/scm-config/lib \
    && mkdir -p /var/lib/scm-config/logs \
    && chown -R nobody:users /var/lib/scm-config
    
#Create Data Directory
RUN mkdir -p /var/lib/scm-data \
    && chown nobody:users /var/lib/scm-data
    
#Create SCM directory
RUN mkdir -p /var/lib/scm \
    && ln -s /var/lib/scm-data /var/lib/scm/repositories \
    && ln -s /var/lib/scm-config/config /var/lib/scm/config \
    && ln -s /var/lib/scm-config/lib /var/lib/scm/lib \
    && ln -s /var/lib/scm-config/logs /var/lib/scm/logs \
    && chown -R nobody:users /var/lib/scm

WORKDIR /var/lib/scm
USER nobody

VOLUME /var/lib/scm-config/config
VOLUME /var/lib/scm-config/lib
VOLUME /var/lib/scm-config/logs
VOLUME /var/lib/scm-data
EXPOSE 8080

CMD ["/opt/scm-server/bin/scm-server"]