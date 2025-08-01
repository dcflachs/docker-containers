ARG DEBIAN_VERSION=debian-11-v4
FROM jlesage/baseimage-gui:${DEBIAN_VERSION}

ARG DEBIAN_VERSION=Debian-11
ARG VERACRYPT_VERSION=1.26.24

MAINTAINER dcflachs

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99
ENV GROUP_ID=100

ENV UMASK=000

# Gui App Name default is "GUI_APPLICATION"
RUN set-cont-env APP_NAME "VeraCrypt"
RUN set-cont-env APP_VERSION $VERACRYPT_VERSION

# Default resolution, change if you like
ENV DISPLAY_WIDTH=1280
ENV DISPLAY_HEIGHT=720

# Use a secure connection to the GUI
ENV SECURE_CONNECTION 1

# Clean tmp on startup
ENV CLEAN_TMP_DIR 1

# Install packages needed for app
RUN \
    add-pkg --force-yes \ 
        ntfs-3g \
        sudo \
        libfuse2 \
        dmsetup \
        libwxgtk3.0-gtk3-0v5 \
        procps \
        libayatana-appindicator3-1 \
        nano \
        libpcsclite1 \
        pcscd \
        btrfs-progs

#########################################
##    REPOSITORIES AND DEPENDENCIES    ##
#########################################
RUN \
	add-pkg --virtual build-dependencies \
        wget ca-certificates gnupg && \
	wget -nv https://launchpad.net/veracrypt/trunk/$VERACRYPT_VERSION/+download/veracrypt-$VERACRYPT_VERSION-$DEBIAN_VERSION-amd64.deb -O veracrypt.deb && \
    dpkg -i veracrypt.deb && \
    rm veracrypt.deb && \
	del-pkg build-dependencies

# Copy X app start script to correct location
COPY --chmod=777 startapp.sh /startapp.sh

# Copy default configuration file to correct location
COPY Configuration.xml /defaults/Configuration.xml

# Add veracrypt init script
COPY --chmod=777 veracrypt.sh /etc/cont-init.d/90-veracrypt.sh

# Add veracrypt sudoers script
COPY --chmod=777 sudoers.sh /etc/cont-init.d/01-veracrypt-sudoers.sh

# Add dismount script
COPY --chmod=777 dismount /etc/cont-finish.d/dismount

# Fix PAM configuration
RUN DEBIAN_FRONTEND=noninteractive pam-auth-update --package --remove unix
# RUN \
#     add-pkg --virtual deps \
#         debconf-utils && \
#     echo libpam-runtime libpam-runtime/profiles multiselect systemd | debconf-set-selections && \
#     DEBIAN_FRONTEND=noninteractive pam-auth-update --package && \
#     del-pkg deps

COPY veracrypt.png /veracrypt.png

# Generate and install favicons.
RUN \
    APP_ICON_URL=/veracrypt.png && \
    install_app_icon.sh "$APP_ICON_URL"

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################

# Place whatever volumes and ports you want exposed here:
VOLUME ["/mnt/containers"]
VOLUME ["/mnt/disks"]

