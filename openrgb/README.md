# OpenRBG
This is an unofficial container for the OpenRBG app. Please visit the [OpenRBG Project Page](https://gitlab.com/CalcProgrammer1/OpenRGB) for information on how to use this app.

## WARNING: Please read the OpenRGB Project Page before attempting to install this container. OpenRGB requires low level access to your system hardware and using it incorrectly could potentially damage your hardware. You should read the Warning section of the official project page carefully.

This image is based on [jlesage/baseimage-gui:debian-9](https://hub.docker.com/r/jlesage/baseimage-gui/)



## Usage

```
docker create \
--name="OpenRGB" \
--net="bridge" \
-e "DISPLAY_WIDTH"="1280" \
-e "DISPLAY_HEIGHT"="720" \
-p XXXX:5800/tcp \
--device=/dev/i2c-X \
--device=/dev/i2c-X \
dcflachs/openrgb
```

`This container requires device drivers to be installed on the docker host system. See the project page for details pertaining to your particular system.`


## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `--net=bridge` - Shares host networking with container.
* `-p XXXX:5800/tcp` - Pass through port to web GUI.
* `-e DISPLAY_WIDTH=` - Adjust screen width of WEB GUI.
* `-e DISPLAY_HEIGHT=` - Adjust screen height of WEB GUI.
* `--device=/dev/i2c-X` - Accessing RGB hardware typically requires access to one or more system i2c devices.
* `-v /dev/bus/usb:/dev/bus/usb` - [Optional] Accessing RGB hardware may require access to USB devices.


## Accessing the application
Webui can be found at `<your-ip>:XXXX/web`

## Info

* Shell access whilst the container is running: `docker exec -it OpenRGB /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f OpenRGB`
