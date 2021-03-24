#!/bin/bash

#--------------------------------------------------
# Configuration Settings
#--------------------------------------------------
OE_USER="odoo"
OE_HOME="/opt/$OE_USER"
OE_HOME_EXT="/$OE_USER/server"
OE_VERSION="10.0"
OE_SUPERADMIN="admin"
OE_CONFIG="${OE_USER}-server"

#--------------------------------------------------
# Install Red Hat Dependencies using YUM
#--------------------------------------------------
sudo yum install wget vim -y

echo -e "\n---- Install tool packages ----"
sudo yum install gcc python-devel wget git gdebi-core -y
sudo python get-pip.py

#--------------------------------------------------
# Install Node and NPM Packages
#--------------------------------------------------
echo -e "\n--- Install Node and NPM packages"
sudo yum install -y gcc-c++ make
sudo curl -sL https://rpm.nodesource.com/setup_11.x | sudo -E bash -
sudo yum install nodejs -y
sudo npm install -g less

#--------------------------------------------------
# Install Node and NPM Packages
#--------------------------------------------------

echo -e "\n---- Create ODOO system user ----"
sudo adduser --system --shell=/bin/bash --home=$OE_HOME --user-group  $OE_USER

echo -e "\n---- Create Log directory ----"
sudo mkdir /var/log/$OE_USER
sudo chown $OE_USER:$OE_USER /var/log/$OE_USER

#--------------------------------------------------
# Install Wkhtmltopdf if needed
# wget https://downloads.wkhtmltopdf.org/0.12/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
#--------------------------------------------------
sudo yum install -y xorg-x11-fonts-75dpi xorg-x11-fonts-Type1 openssl git-core fontconfig
sudo  tar xvf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
sudo  mv wkhtmltox/bin/wkhtmlto* /usr/bin

#--------------------------------------------------
# Clone Odoo Modules
#--------------------------------------------------

echo -e "\n---- Create custom module directory ----"
sudo su $OE_USER -c "mkdir $OE_HOME/server"
sudo su $OE_USER -c "mkdir -p $OE_HOME/custom/addons"
sudo su $OE_USER -c "mkdir $OE_HOME/osapps"

echo -e "\n---- Setting permissions on home folder ----"
sudo chown -R $OE_USER:$OE_USER $OE_HOME/*

echo -e "\n---- Clone Odoo modules ----"
sudo git clone --branch 10.0 https://www.github.com/odoo/odoo $OE_HOME/server/
sudo pip install -r $OE_HOME/server/requirements.txt

#echo -e "\n---- Dependent modules ----"
sudo cp -R osapps/* $OE_HOME/osapps/

#echo -e "\n---- OGL modules ----"
sudo cp -R custom/* $OE_HOME/custom/

echo -e "* Create server config file"
sudo cp odoo.conf /etc/odoo.conf
sudo chown $OE_USER:$OE_USER /etc/$OE_CONFIG.conf
sudo chmod 640 /etc/$OE_CONFIG.conf

echo -e "\n---- Create Log directory ----"
sudo mkdir /var/log/$OE_USER
sudo chown $OE_USER:$OE_USER /var/log/$OE_USER


echo -e "* Create startup file"
sudo su root -c "echo '#!/bin/sh' >> $OE_HOME_EXT/odoo.sh"
sudo su root -c "echo 'sudo -u $OE_USER $OE_HOME_EXT/odoo-bin --config=/etc/odoo.conf' >> $OE_HOME_EXT/odoo.sh"
sudo cp $OE_HOME_EXT/odoo.sh /etc/odoo.sh
sudo chmod 755 /etc/odoo.sh

echo -e "* Create boot script file"
echo "
[Unit]
Description=OGL Application
[Service]
ExecStart=/etc/odoo.sh
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s TERM $MAINPID
[Install]
WantedBy=multi-user.target" > /usr/lib/systemd/system/odoo.service

sudo systemctl enable odoo.service
sudo systemctl start odoo.service

#--------------------------------------------------
# Install Python Packages
#--------------------------------------------------
pip install -r pip.txt



echo -e "\n---- Install PostgreSQL Server ----"

sudo wget https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-redhat10-10-2.noarch.rpm
sudo yum install pgdg-redhat10-10-2.noarch.rpm -y

sudo yum install postgresql10-server postgresql10 -y
sudo /usr/pgsql-10/bin/postgresql-10-setup initdb

echo -e "\n---- Creating the ODOO PostgreSQL User  ----"
sudo su - postgres -c "createuser -s $OE_USER" 2> /dev/null || true

sudo systemctl enable postgresql-10.service
sudo systemctl start postgresql-10.service