# Docker Proxy ACL
[VeraCrypt](https://github.com/titpetric/docker-proxy-acl) is a docker unix socket proxy which restricts endpoint usage to allowed sections.

This image is based on [kmlucy/docker-proxy-acl](https://hub.docker.com/r/kmlucy/docker-proxy-acl/)

## Usage

```
docker create \
--name="proxy" \
--net="none" \
-e "OPTIONS= -a containers -a version" \
-v /tmp/docker-proxy-acl:/tmp/docker-proxy-acl \
-v /var/run/docker.sock:/var/run/docker.sock \
dcflachs/docker-proxy-acl
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. `

* `--net=none` - This container should not have network access.
* `-e OPTIONS` - The endpoints to enable, see below. **defaults to containers**
* `-v /var/run/docker.sock` - Path to the docker socket.
* `-v /tmp/docker-proxy-acl` - Path to the folder where the new proxy socket will be placed. **tmp is recommended**

## Endpoint Options
`Endpoints can be enabled by using the -a argument in the OPTION variable.
Multiple endpoints can be combined by repeating -a flag.`
* `containers` - opens access to /containers/json and /containers/{name}/json
* `images` - opens access to /images/json , /images/{name}/json and /images/{name}/history
* `networks` - opens access to /networks and /networks/{name}
* `volumes` - opens access to /volumes and /volumes/{name}
* `services` - opens access to /services and /services/{id}
* `tasks` - opens access to /tasks and /tasks/{name}
* `events` - opens access to /events
* `info` - opens access to /info
* `version` - opens access to /version
* `ping` - opens access to /_ping
