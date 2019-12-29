F
OM ubuntu:16.04
MAINTAINER gitmehedi

# make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
#RUN locale-gen en_US.UTF-8
#RUN update-locale LANG=en_US.UTF-8

RUN set -x; apt-get update -y && apt-get install wget vim  
#Install and setup postgresql

RUN  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
RUN sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" > /etc/apt/sources.list.d/PostgreSQL.list'
RUN set -x; \
        apt-get update \
        && apt-get install -y postgresql-10
#USER postgres
#RUN /etc/init.d/postgresql start  && psql --command "CREATE USER root WITH SUPERUSER CREATEDB REPLICATION;"
#USER root
#ENV PGDATA /var/lib/postgresql/data


RUN set -x; apt-get update -y && apt-get install -y wget unzip vim 
RUN set -x;  apt-get install -y \ 
                     libsasl2-dev \
                     python-dev \
                     libldap2-dev \
                     libssl-dev \
                     python-pip \
                     python-dev \
                     python-ldap \
                     libxslt-dev \
                     vim \
                     wget \
                     git 
RUN set -x; mkdir -p /opt/odoo && cd /opt/odoo && mkdir server custom osapps

#Install Odoo
#RUN set -x; git clone -b 10.0 --single-branch https://github.com/odoo/odoo.git /opt/odoo/server/10.0
COPY ./odoo.zip /opt/odoo/server/
RUN set -x; unzip /opt/odoo/server/odoo.zip -d /opt/odoo/server/

# Copy dependencies of Odoo
RUN set -x; pip install --no-cache -r /opt/odoo/server/10.0/requirements.txt
COPY ./odoo.conf /etc/odoo/

# Set the default config file
ENV ODOO_RC /etc/odoo/odoo.conf

VOLUME ["/opt/odoo/","/etc/odoo/","/var/lib/postgresql"]

EXPOSE 8069

ENTRYPOINT ["/bin/bash"]
