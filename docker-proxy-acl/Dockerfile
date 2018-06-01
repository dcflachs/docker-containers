FROM golang:1-alpine3.5
MAINTAINER dcflachs

# Add helpers from jlesage/docker-baseimage
ADD https://raw.githubusercontent.com/jlesage/docker-baseimage/master/helpers/add-pkg /usr/local/bin/
ADD https://raw.githubusercontent.com/jlesage/docker-baseimage/master/helpers/del-pkg /usr/local/bin/
ADD https://raw.githubusercontent.com/jlesage/docker-baseimage/master/helpers/sed-patch /usr/local/bin/

RUN chmod +x /usr/local/bin/add-pkg
RUN chmod +x /usr/local/bin/del-pkg
RUN chmod +x /usr/local/bin/sed-patch

RUN \
	add-pkg --virtual build-dependencies \
		ca-certificates curl unzip && \
	curl -LJO https://github.com/dcflachs/docker-proxy-acl/archive/master.zip && \
	unzip docker-proxy-acl-master.zip && \
	cp /docker-proxy-acl-master/docker-proxy-acl.go /go/src/app && \
	cp -r /docker-proxy-acl-master/proxy/ /go/src/app/proxy && \
	cp -r /docker-proxy-acl-master/vendor/ /go/src/app/vendor && \
	rm docker-proxy-acl-master.zip && \
	rm -R /docker-proxy-acl-master && \
	del-pkg build-dependencies

WORKDIR /go/src/app

ENV OPTIONS="-a containers"

CMD (rm -f /tmp/docker-proxy-acl/docker.sock || rmdir /tmp/docker-proxy-acl/docker.sock) ; go run docker-proxy-acl.go $OPTIONS