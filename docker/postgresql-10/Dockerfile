FROM ubuntu:16.04
MAINTAINER gitmehedi

RUN set -x; apt-get update -y
RUN set -x; apt-get install -y sudo \
                            wget \
                            lsb-release \
                            vim

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" > /etc/apt/sources.list.d/PostgreSQL.list'
RUN set -x; apt-get -y update && apt-get install postgresql-10 -y

USER postgres
RUN psql -c "CREATE USER odoo WITH LOGIN PASSWORD 'odoo';" 2> /dev/null || true


USER root
COPY ./start.sh /var/
RUN chmod 777 /var/start.sh

EXPOSE 5432

ENTRYPOINT ["/bin/bash","/var/start.sh"]
CMD [""]
