FROM jlesage/baseimage-gui:debian-9

MAINTAINER dcflachs

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99
ENV GROUP_ID=100

# Gui App Name default is "GUI_APPLICATION"
ENV APP_NAME="OpenRGB"

# Default resolution, change if you like
ENV DISPLAY_WIDTH=1280
ENV DISPLAY_HEIGHT=720

# Use a secure connection to the GUI
ENV SECURE_CONNECTION 1

# Clean tmp on startup
ENV CLEAN_TMP_DIR 1

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://assets.gitlab-static.net/uploads/-/system/project/avatar/10582521/OpenRGB.png && \
    install_app_icon.sh "$APP_ICON_URL"

#########################################
##    REPOSITORIES AND DEPENDENCIES    ##
#########################################

WORKDIR /

RUN add-pkg libusb-1.0-0-dev i2c-tools qt5-default libhidapi-dev

RUN \
	add-pkg --virtual build-dependencies \
		git build-essential qtcreator make ca-certificates  && \
	git clone https://gitlab.com/CalcProgrammer1/OpenRGB && \
	cd OpenRGB && \
	qmake OpenRGB.pro && \
	make -j8 && \
	del-pkg build-dependencies

# Copy X app start script to correct location
COPY startapp.sh /startapp.sh

RUN chmod 777 /startapp.sh

COPY 02-fix-attrs-i2c.sh /etc/cont-init.d/

RUN chmod 777 /etc/cont-init.d/02-fix-attrs-i2c.sh