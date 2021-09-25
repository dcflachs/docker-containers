FROM jlesage/baseimage-gui:debian-10

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

# Install packages needed for app
RUN add-pkg --force-yes ntfs-3g sudo libfuse2 dmsetup libwxgtk3.0-gtk3-0v5

#########################################
##    REPOSITORIES AND DEPENDENCIES    ##
#########################################
RUN \
	add-pkg --virtual build-dependencies \
        wget ca-certificates gnupg && \
	wget -nv https://launchpad.net/veracrypt/trunk/1.24-update7/+download/veracrypt-1.24-Update7-Debian-10-amd64.deb -O veracrypt.deb && \
    dpkg -i veracrypt.deb && \
    rm veracrypt.deb && \
	del-pkg build-dependencies

# Copy X app start script to correct location
COPY startapp.sh /startapp.sh

# Copy default configuration file to correct location
COPY Configuration.xml /defaults/Configuration.xml

# Add veracrypt init script
COPY veracrypt.sh /etc/cont-init.d/90-veracrypt.sh

# Add veracrypt sudoers file
RUN echo "$APP_USER ALL=(root) NOPASSWD:/usr/bin/veracrypt" > /etc/sudoers.d/veracrypt
RUN chmod 440 /etc/sudoers.d/veracrypt

# Generate and install favicons.
RUN \
    APP_ICON_URL=http://www.top-windows-tutorials.com/images/2013/04/veracrypt-logo.png && \
    install_app_icon.sh "$APP_ICON_URL"

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################

# Place whatever volumes and ports you want exposed here:
VOLUME ["/mnt/containers"]
VOLUME ["/mnt/disks"]

