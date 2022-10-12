FROM debian:jessie
MAINTAINER Odoo S.A. <info@odoo.com>

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            ca-certificates \
            curl \
            npm \
            git \
            vim \
            wget \
            node-less \
            python-gevent \
            python-pip \
            python-pyinotify \
            python-renderpm \
            python-support \
        # && curl -o wkhtmltox.deb -SL http://nightly.odoo.com/extra/wkhtmltox-0.12.1.2_linux-jessie-amd64.deb \
        # && echo '40e8b906de658a2221b15e4e8cd82565a47d7ee8 wkhtmltox.deb' | sha1sum -c - \
        # && dpkg --force-depends -i wkhtmltox.deb \
        # && apt-get -y install -f --no-install-recommends \
        # && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false npm \
        # && rm -rf /var/lib/apt/lists/* wkhtmltox.deb \
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

# Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
COPY ./odoo.conf /etc/odoo/
RUN chown odoo:odoo /etc/odoo/odoo.conf

# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /mnt/extra-addons \
    && mkdir -p /mnt/extra-addons/custom \
    && mkdir -p /mnt/extra-addons/osapps \
    && chown -R odoo:odoo /mnt/extra-addons \
    && chown -R odoo:odoo /mnt/extra-addons/custom \
    && chown -R odoo:odoo /mnt/extra-addons/osapps \ 
    # @BUGFIX
    # During the database creation process, the system creates an empty filestore dir
    # with root:root permission, returning a permission error.
    && mkdir -m 700 /var/lib/odoo/filestore \
    && chown -R odoo:odoo /var/lib/odoo/filestore
VOLUME ["/var/lib/odoo", "/mnt/extra-addons"]

COPY ./requirements.txt /mnt/requirements.txt
RUN python -m pip install -r /mnt/requirements.txt

# WORKDIR /mnt/extra-addons/custom
# RUN git clone -b emk_dev --single-branch https://github.com/genweb2/gbs.git emk

WORKDIR /mnt/extra-addons/osapps
RUN git clone -b 10.0 --single-branch https://github.com/oca/server-tools.git \
    && git clone -b 10.0 --single-branch https://github.com/oca/contract.git \
    && git clone -b 10.0 --single-branch https://github.com/oca/event.git \
    && git clone -b 10.0 --single-branch https://github.com/oca/hr.git \
    && git clone -b 10.0 --single-branch https://github.com/oca/operating-unit.git \
    && git clone -b 10.0 --single-branch https://github.com/oca/partner-contact.git \
    && git clone -b 10.0 --single-branch https://github.com/oca/reporting-engine.git \
    && git clone -b 10.0 --single-branch https://github.com/oca/sale-workflow.git \
    && git clone -b 10.0 --single-branch https://github.com/oca/vertical-association.git \
    && git clone -b tko-addons --single-branch https://github.com/gitmehedi/oca_addons.git tko-addons \
    && git clone -b oca --single-branch https://github.com/gitmehedi/oca_addons.git oca

# Expose Odoo services
EXPOSE 8069 8071

# Set the default config file
ENV ODOO_RC /etc/odoo/odoo.conf

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]