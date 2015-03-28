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

# Use baseimage-docker's init system
#CMD ["/sbin/my_init"]

# Configure user nobody to match unRAID's settings
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody
RUN usermod -d /home nobody
RUN chown -R nobody:users /home

RUN apt-get update \
    && apt-get install -qq -y default-jre \  
    && apt-get autoremove \
    && apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle    
    

