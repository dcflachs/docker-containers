FROM openjdk:8-jdk-alpine
MAINTAINER dcflachs <dcflachs@gmail.com>

ENV SCM_VERSION 1.49
ENV SCM_PKG_URL https://maven.scm-manager.org/nexus/content/repositories/releases/sonia/scm/scm-server/${SCM_VERSION}/scm-server-${SCM_VERSION}-app.tar.gz
ENV SCM_HOME /var/lib/scm

#Install curl and mercurial
RUN apk add --no-cache \
	curl  \
	mercurial

#Install shadow
RUN  apk add --no-cache \
	--repository http://nl.alpinelinux.org/alpine/edge/community \
	shadow

#Install scm-server
RUN mkdir -p /opt \
	&& curl -Lks "$SCM_PKG_URL" | tar -zxC /opt \
 	&& mkdir -p /var/lib/scm \
 	&& sed -i -e "s/^#!\/bin\/bash/#!\/bin\/sh/" /opt/scm-server/bin/scm-server \
	&& chmod +x /opt/scm-server/bin/scm-server
    
#Create Config Directories
RUN mkdir -p /var/lib/scm-config \
    && mkdir -p /var/lib/scm-config/comfig \
    && mkdir -p /var/lib/scm-config/lib \
    && mkdir -p /var/lib/scm-config/logs
    
#Create Data Directory
RUN mkdir -p /var/lib/scm-data
    
#Create SCM directory
RUN mkdir -p /var/lib/scm \
    && ln -s /var/lib/scm-data /var/lib/scm/repositories \
    && ln -s /var/lib/scm-config/config /var/lib/scm/config \
    && ln -s /var/lib/scm-config/lib /var/lib/scm/lib \
    && ln -s /var/lib/scm-config/logs /var/lib/scm/logs

WORKDIR /var/lib/scm

VOLUME /var/lib/scm-config/config
VOLUME /var/lib/scm-config/lib
VOLUME /var/lib/scm-config/logs
VOLUME /var/lib/scm-data
EXPOSE 8080

CMD ["/opt/scm-server/bin/scm-server"]