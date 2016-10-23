FROM dcflachs/clamav

VOLUME /malware

WORKDIR /

ENTRYPOINT ["/usr/bin/clamscan", "-r"]

CMD ["/malware"]