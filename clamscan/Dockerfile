FROM dcflachs/clamav

VOLUME /malware

WORKDIR /

ENTRYPOINT ["/usr/bin/clamscan", "--max-filesize=4000M", "-r"]

CMD ["/malware"]