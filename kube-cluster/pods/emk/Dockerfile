FROM debian:jessie
MAINTAINER Md Mehedi Hasan <git.mehedi@gmail.com>

# Install os dependecies, python dependencies
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            ca-certificates \
            curl \
            npm \
            git \
            vim \
            wget \
            libmagickwand-dev \
            python-gevent \
            python-pip \
            python-pyinotify \
            python-renderpm \
            python-support \
            python-renderpm \
            python-watchdog \
        && pip install psycogreen==1.0

# ========== Install node, lessc and wkhtmltopdf ==========
#RUN set -x; npm install -g lessc && apt-get install -y wkhtmltopdf nodejs-legacy
RUN set -x; apt-get install -y wkhtmltopdf node-less && npm install -g lessc

# Install Odoo
ENV ODOO_VERSION 10.0
ENV ODOO_RELEASE latest
RUN set -x; \
        curl -o odoo.deb -SL http://nightly.odoo.com/${ODOO_VERSION}/nightly/deb/odoo_${ODOO_VERSION}.${ODOO_RELEASE}_all.deb \
        && curl -o odoo.sha -SL http://nightly.odoo.com/${ODOO_VERSION}/nightly/deb/odoo_${ODOO_VERSION}.${ODOO_RELEASE}_amd64.changes \
        && echo $(cat odoo.sha | grep -E -e "^\s[a-z,0-9]{40}\s.*_all\.deb$" | cut -f 2 -d " ") 'odoo.deb' | sha1sum -c - \
        && dpkg --force-depends -i odoo.deb \
        && apt-get update \
        && apt-get -y install -f --no-install-recommends \
        && rm -rf /var/lib/apt/lists/* odoo.deb odoo.sha


# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /mnt/extra-addons \
    && mkdir -p  /mnt/extra-addons/custom \
    && mkdir -p /mnt/extra-addons/osapps \
    && chown -R odoo:odoo /mnt/extra-addons \
    && chmod 2777 /mnt/extra-addons \

    # @BUGFIX
    # During the database creation process, the system creates an empty filestore dir
    # with root:root permission, returning a permission error.
    && mkdir -m 777 /var/lib/odoo/filestore \
    && chown -R odoo:odoo /var/lib/odoo/filestore


COPY ./requirements.txt /mnt/requirements.txt
RUN python -m pip install -r /mnt/requirements.txt


WORKDIR /mnt/extra-addons/osapps
RUN git clone -b server-tools --single-branch https://github.com/gitmehedi/oca_addons.git server-tools \
    && git clone -b contract --single-branch https://github.com/gitmehedi/oca_addons.git contract \
    && git clone -b event --single-branch https://github.com/gitmehedi/oca_addons.git event \
    && git clone -b hr --single-branch https://github.com/gitmehedi/oca_addons.git hr \
    && git clone -b operating-unit --single-branch https://github.com/gitmehedi/oca_addons.git operating-unit \
    && git clone -b partner-contact --single-branch https://github.com/gitmehedi/oca_addons.git partner-contact \
    && git clone -b reporting-engine --single-branch https://github.com/gitmehedi/oca_addons.git reporting-engine \
    && git clone -b sale-workflow --single-branch https://github.com/gitmehedi/oca_addons.git sale-workflow \
    && git clone -b vertical-association --single-branch https://github.com/gitmehedi/oca_addons.git vertical-association \
    && git clone -b tko-addons --single-branch https://github.com/gitmehedi/oca_addons.git tko-addons \
    && git clone -b oca --single-branch https://github.com/gitmehedi/oca_addons.git oca


# Add application repository
WORKDIR /mnt/extra-addons/custom
ARG SSH_KEY
RUN git config --global url."https://${SSH_KEY}:@github.com/".insteadOf "https://github.com/"
RUN git clone -b emk_dev --single-branch https://github.com/genweb2/gbs.git emk

WORKDIR /mnt

# Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /mnt/entrypoint.sh 
COPY ./odoo.conf /etc/odoo/

RUN chmod +x /mnt/entrypoint.sh \
    && chown odoo:odoo /etc/odoo/odoo.conf \
    && chown odoo:odoo /mnt/entrypoint.sh \
    && chown -R odoo:odoo /mnt/extra-addons/osapps \
    && chown -R odoo:odoo /mnt/extra-addons/custom \
    && chmod 777 /mnt/extra-addons/osapps \
    && chmod 777 /mnt/extra-addons/custom 

VOLUME ["/var/lib/odoo", "/mnt/extra-addons"]

# Expose Odoo services
EXPOSE 8069 8071

# Set the default config file
ENV ODOO_RC /etc/odoo/odoo.conf


# Set default user when running the container
USER odoo

ENTRYPOINT ["/mnt/entrypoint.sh"]
CMD ["odoo"]