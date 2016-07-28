#!/usr/bin/env bash

##############################
## DISABLE APACHE WEBSITE   ##
##############################

# INPUT 1: server name
if [ -z $1 ]
then
 # no input 1
 echo "(2) NO SERVER NAME SPECIFIED. Mush be <website>.vagrant"
 echo "Example: project.vagrant"
 exit
fi

a2dissite $1
service apache2 restart
cd /etc/apache2/sites-available
rm "$1".conf