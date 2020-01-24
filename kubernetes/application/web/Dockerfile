FROM ubuntu:16.04
MAINTAINER gitmehedi

RUN set x; apt-get -y update && apt-get install -y wget vim sudo curl lsb-release apt-utils

FROM nginx:latest
RUN set x; apt-get install -y nginx

COPY start.sh /var/start.sh
RUN chmod 777 /var/start.sh

EXPOSE 80
ENTRYPOINT ["/bin/bash","/var/start.sh"]
CMD [""]