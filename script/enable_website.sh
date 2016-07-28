#!/usr/bin/env bash

#############################
## ENABLE APACHE WEBSITE   ##
#############################

# INPUT 1: web folder
if [ -z $1 ]
then
 # no input 1
 echo "(1) NO WEB FOLDER SPECIFIED"
 echo "Example: /var/www/project.com/"
 exit
fi
# INPUT 2: server name
if [ -z $2 ]
then
 # no input 2
 echo "(2) NO SERVER NAME SPECIFIED. Mush be <website>.vagrant"
 echo "Example: project.vagrant"
 exit
fi

cd /etc/apache2/sites-available/
rm "$2".conf
touch "$2".conf
website_name=$2.conf

cat <<EOF > $website_name
<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.

        ServerName $2

        ServerAdmin webmaster@localhost
        DocumentRoot $1
        <Directory $1>
                EnableSendfile Off
        </Directory>


        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

EOF

a2ensite $website_name
service apache2 restart