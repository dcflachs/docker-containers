# Pull base image.
FROM jlesage/baseimage-gui:debian-8

MAINTAINER dcflachs

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99
ENV GROUP_ID=100

ENV UMASK=000

# Gui App Name default is "GUI_APPLICATION"
ENV APP_NAME="VeraCrypt"

# Default resolution, change if you like
ENV DISPLAY_WIDTH=1280
ENV DISPLAY_HEIGHT=720

# Use a secure connection to the GUI
ENV SECURE_CONNECTION 1

# Clean tmp on startup
ENV CLEAN_TMP_DIR 1

#########################################
##    REPOSITORIES AND DEPENDENCIES    ##
#########################################
RUN \
	echo 'deb http://download.opensuse.org/repositories/home:/stevenpusser:/veracrypt/Debian_8.0/ /' > /etc/apt/sources.list.d/veracrypt.list 

# Install packages needed for app
RUN \
	add-pkg veracrypt ntfs-3g

# Copy X app start script to right location
COPY startapp.sh /startapp.sh

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################

# Place whatever volumes and ports you want exposed here:
VOLUME ["/mnt/containers"]
VOLUME ["/mnt/disks"]

