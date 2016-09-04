#!/bin/bash
source setup/functions.sh # load our functions
source /etc/mailinabox.conf # load global vars

echo "Installing MySQL server..."

apt_install mysql-server

# We need this password for later to auth Dovecot, Postfix and SOGo.
# TODO: This isn't optimal. We should do better... later...
MIAB_SQL_PW=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13`

# Mailinabox database name
MIAB_SQL_DB="mailinabox"
SOGO_SQL_DB="sogo"

# Setup the MIAB database, but first check that it doesn't exist already
if [ ! -d /var/lib/mysql/$MIAB_SQL_DB ]; then
    # Create the MIAB and SOGO database
    mysql --defaults-file=/etc/mysql/debian.cnf -e "CREATE DATABASE ${MIAB_SQL_DB}; CREATE DATABASE ${SOGO_SQL_DB};" >> /dev/null
    # Import our preconfigured database to MySQL
    mysql --defaults-file=/etc/mysql/debian.cnf ${MIAB_SQL_DB} < conf/mailinabox_init.sql >> /dev/null
fi

# Create and grant privs for mailinabox user so that postfix/dovecot and SOGo can interact with the DB
mysql --defaults-file=/etc/mysql/debian.cnf -e "GRANT ALL PRIVILEGES ON ${MIAB_SQL_DB}.* TO 'mailinabox'@'%' IDENTIFIED BY '${MIAB_SQL_PW}'; GRANT ALL PRIVILEGES ON ${SOGO_SQL_DB}.* TO 'mailinabox'@'%' IDENTIFIED BY '${MIAB_SQL_PW}'; FLUSH PRIVILEGES;" >> /dev/null

### TESTING
#mysql --defaults-file=/etc/mysql/debian.cnf -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('1234'); FLUSH PRIVILEGES;" >> /dev/null
#mysql --defaults-file=/etc/mysql/debian.cnf -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'test123';"
#tools/editconf.py /etc/mysql/mysql.conf.d/mysqld.cnf "bind-address=0.0.0.0"
#restart_service mysql
#hide_output ufw allow mysql