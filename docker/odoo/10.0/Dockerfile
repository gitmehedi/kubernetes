FROM ubuntu:16.04
MAINTAINER gitmehedi

RUN set -x; apt-get update -y && apt-get install wget vim lsb-release sudo vim wget git npm curl -y

# ========== Install and setup postgresql ==========

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" > /etc/apt/sources.list.d/PostgreSQL.list'
RUN set -x; apt-get -y update && apt-get install postgresql-10 -y

# ========== Install odoo depened python packages ==========

RUN set -x; apt-get update -y && apt-get install -y wget unzip vim
RUN set -x;  apt-get install -y \
                     libsasl2-dev \
                     python-dev \
                     libldap2-dev \
                     libssl-dev \
                     python-pip \
                     python-dev \
                     python-ldap \
                     libxslt-dev 

# ========== Install node, lessc and wkhtmltopdf ==========
#RUN set -x; npm install -g lessc && apt-get install -y wkhtmltopdf nodejs-legacy
RUN set -x; apt-get install -y wkhtmltopdf node-less && npm install -g lessc


RUN set -x; mkdir -p /opt/odoo && cd /opt/odoo && mkdir server custom osapps

# ========== Clone odoo from github.com OR local zip file ==========

#RUN set -x; git clone -b 10.0 --single-branch https://github.com/odoo/odoo.git /opt/odoo/server/10.0
COPY ./odoo.zip /opt/odoo/server/
RUN set -x; unzip /opt/odoo/server/odoo.zip -d /opt/odoo/server/

# ========== Install odoo dependent python packages ==========
RUN set -x; pip install --no-cache -r /opt/odoo/server/10.0/requirements.txt
COPY ./odoo.conf /etc/odoo/

USER root
COPY ./start.sh /var/
RUN chmod 777 /var/start.sh


# ========== Set the default config file ==========
ENV ODOO_RC /etc/odoo/odoo.conf

VOLUME ["/opt/odoo/","/etc/odoo/","/var/lib/postgresql"]

EXPOSE 8069 8071

ENTRYPOINT ["/bin/bash","/var/start.sh"]
CMD [""]
