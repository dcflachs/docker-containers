# Pull base image.
FROM jlesage/baseimage-gui:debian-9

RUN \
	add-pkg --virtual temp software-properties-common && \
	apt-add-repository 'deb http://httpredir.debian.org/debian/ stretch main contrib non-free' && \
	del-pkg temp

RUN dpkg --add-architecture i386

# Install Steam.
RUN \
	echo steam steam/license note '' | debconf-set-selections && \
	echo steam steam/question select "I AGREE" | debconf-set-selections && \
	add-pkg steam steamcmd ca-certificates locales

RUN \
	add-pkg libgl1-mesa-dri libgl1-mesa-glx libc6 \
	libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 libc6:i386

RUN \
	add-pkg procps #mesa-utils

#ARG MULTIMC_DEB=multimc_1.2-1.deb
#ARG MULTIMC_URL=https://files.multimc.org/downloads/${MULTIMC_DEB}
ARG MULTIMC_VERSION=0.6.5
ARG MULTIMC_TAR=mmc-stable-lin64.tar.gz
ARG MULTIMC_URL=https://github.com/MultiMC/MultiMC5/releases/download/${MULTIMC_VERSION}/${MULTIMC_TAR}

RUN \
    add-pkg curl tar gzip file qt5-default libxkbcommon0 

RUN \
	mkdir -p /usr/share/man/man1 && \
	add-pkg openjdk-8-jdk

RUN \
        mkdir -p /mc && \
	cd /mc && \
        curl -L -O ${MULTIMC_URL} && \
	file ${MULTIMC_TAR} && \
        tar -xvf ${MULTIMC_TAR} && \
	rm ${MULTIMC_TAR} && \
	cd ./MultiMC/bin && \
	rm libQt5* libxcb* libicu* libpng* libstd* && \
	cd / && \
	chmod -R 777 /mc 

RUN sed-patch 's/x24/x24 +extension GLX +render -noreset/' /etc/services.d/xvfb/run

RUN sed-patch 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8  

RUN \
    # Maximize only the main/initial window.
    sed-patch 's/<application type="normal">/<application type="normal" title="Steam">/' \
        /etc/xdg/openbox/rc.xml && \
    # Make sure the main window is always in the background.
    sed-patch '/<application type="normal" title="Steam">/a \    <layer>below</layer>' \
        /etc/xdg/openbox/rc.xml

RUN mkdir -p /steam/.steam/steam/
RUN chmod -R 777 /steam

# Copy the start script.
COPY startapp.sh /startapp.sh

# Copy the start script.
COPY 00-take-mc-ownership.sh /etc/cont-init.d/00-take-mc-ownership.sh

# Set the name of the application.
ENV APP_NAME="MultiMC	"

#Steam In Home Streaming Ports
EXPOSE 27031/udp 27036/udp 27036/tcp 27037/tcp

#MultiMC Instances Directory
VOLUME /mc/MultiMC/bin/instances