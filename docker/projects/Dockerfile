FROM ubuntu:16.04
MAINTAINER gitmehedi

# make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
#RUN locale-gen en_US.UTF-8
#RUN update-locale LANG=en_US.UTF-8

#Install and setup postgresql
RUN set -x; \
        apt-get update \
        && apt-get install -y postgresql
USER postgres
RUN /etc/init.d/postgresql start  && psql --command "CREATE USER root WITH SUPERUSER CREATEDB REPLICATION;"
USER root
ENV PGDATA /var/lib/postgresql/data


RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            git \
	    sudo \
            ca-certificates \
            curl \
            node-less \
            npm \
            python-gevent \
            python-pip \
            python-pyinotify \
            python-renderpm
RUN set -x; mkdir -p /opt/odoo && cd /opt/odoo && mkdir server custom osapps

#Install Odoo
RUN set -x; \
        curl -o odoo.deb -SL http://nightly.odoo.com/10.0/nightly/deb/odoo_10.0.latest_all.deb \
        && dpkg --force-depends -i odoo.deb \
        && apt-get update \
        && apt-get -y install -f --no-install-recommends

 
