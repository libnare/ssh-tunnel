FROM alpine:3.16

RUN apk --no-cache add openssh-client

ADD run.sh /scripts/run.sh

# Add executable permission to the script
RUN chmod +x /scripts/run.sh

# Security fix for CVE-2016-0777 and CVE-2016-0778
RUN echo -e 'Host *\nUseRoaming no' >> /etc/ssh/ssh_config

ENTRYPOINT ["/bin/sh", "-c", "/scripts/run.sh"]
