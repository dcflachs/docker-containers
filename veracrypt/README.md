# VeraCrypt
[VeraCrypt](https://www.veracrypt.fr/en/Home.html) is a free disk encryption software brought to you by [IDRIX](https://www.idrix.fr) and that is based on TrueCrypt 7.1a. 
This container is an experimental packaged version of the Veracrypt GUI application. 

## WARNING: This image is experimental and should not be considered secure. This image requires elevated privileges.

This image is based on [jlesage/baseimage-gui:ubuntu-16.04](https://hub.docker.com/r/jlesage/baseimage-gui/)

## Usage

```
docker create \
--name="veracrypt" \
--net="bridge" \
--privileged="true" \
-e TZ=<timezone> \
-e "DISPLAY_WIDTH"="1280" \
-e "DISPLAY_HEIGHT"="720" \
-p XXXX:5800/tcp \
-v </path/to/config/>:"/config/":rw \
-v </path/to/veracrypt/containers/>:"/mnt/containers/":rw \
-v </path/to/mount/images>:"/mnt/disks":shared \
dcflachs/veracrypt-gui
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `--net=bridge` - Shares host networking with container.
* `--privileged=true` - Give extended privileges to this container.
* `-v /config` - VeraCrypt config location. **required**
* `-v /mnt/containers` - Path to a folder containing veracrypt images.
* `-v /mnt/disks` - Path to the folder where VeraCrypt will mount the encrypted file-systems, *must have the shared attribute*.
* `-p XXXX:5800/tcp` - Pass through port to web GUI.
* `-e DISPLAY_WIDTH=` - Adjust screen width of WEB GUI.
* `-e DISPLAY_HEIGHT=` - Adjust screen height of WEB GUI.
* `-e GROUP_ID=` - for GroupID - see below for explanation
* `-e USER_ID=` - for UserID - see below for explanation
* `-e TZ` - for timezone information *eg Europe/London, etc*

## Accessing the application
Webui can be found at `<your-ip>:XXXX/web`

## Info

* Shell access whilst the container is running: `docker exec -it veracrypt /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f veracrypt`
