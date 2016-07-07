# Vagrant Box LAMP Stack

This is a DEV LAMP debian based box. Use it for a basic development.

## Requirements

- virtualbox 5.x
- vagrant >1.8.4
- (in case of error of shared folder mount errors) vagrant vagrant-vbguest plugin (install with the command `vagrant plugin install vagrant-vbguest`)

## How to use

1) download https://github.com/gmdotnet/Vagrant-LAMP/archive/master.zip

2) unzip on your favorite work folder

3) change Vagrantfile - section config.vm.synced_folder to sync your project folder

4) run 'vagrant up'

5) make your configuration on vagrant machine entering by run 'vagrant ssh'

6) have fun!

## OS and base box

- debian/jessie64  8.5.1
- private network ip: 192.168.250.10

## Software Installed

- apache2
- php 5.6
- php-pear
- php5-cli
- php5-curl
- php5-dev
- php5-intl
- php5-mcrypt
- php5-mysql
- mysql-server 5.5
- git
- git-up (plugin for git)
- htop
- curl
- tig
- xdebug
- mc-dbg (midnight commander)
- composer 1.1.3
- n98-magerun 1.97.22
- modman 1.12
- phpmyadmin 4.6.3 - all languages (accessible via *http://phpmyadmin.vagrant* on your file host with the same ip of vagrant machine)
- optipng 0.7.5
- jpegoptim 1.4.1
- mysqltuner 1.6.0

### MySQL server

- created an user called 'local' with root privilegies
- root password is 'vagrant'

### Apache server

- daemon user is 'www-data'
- root folder is '/var/www'
- mod_rewrite and mod_vhost_alias enabled

### Vagrant Provision script

- the script makes a backup of all databases into /home/backup/database/ folder

### Other info

- root password is 'vagrant' but you can simply run 'sudo su' from vagrant user
- if you can't find a configuration in this file before, it means is used the default value
