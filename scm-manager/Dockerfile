FROM phusion/baseimage:0.9.15
MAINTAINER dcflachs <dcflachs@gmail.com>

########################################
##        ENVIRONMENTAL CONFIG        ##
########################################
# Set correct environment variables
ENV HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"
# Use baseimage-docker's init system
#CMD ["/sbin/my_init"]

# Configure user nobody to match unRAID's settings
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody
RUN usermod -d /home nobody
RUN chown -R nobody:users /home

RUN apt-get install -y openjdk-7-jre

RUN apt-get clean -y
