FROM kmlucy/docker-proxy-acl
MAINTAINER dcflachs

CMD (rm -f /tmp/docker-proxy-acl/docker.sock || rmdir /tmp/docker-proxy-acl/docker.sock) && go run docker-proxy-acl.go $OPTIONS