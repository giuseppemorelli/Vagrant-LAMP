[![stable version](https://img.shields.io/badge/stable%20version-1.1.2-green.svg?style=flat-square)](https://github.com/gmdotnet/Vagrant-LAMP/releases/tag/1.1.2)
[![develop](https://img.shields.io/badge/beta%20version-branch%20develop-oran.svg?style=flat-square)](https://github.com/gmdotnet/Vagrant-LAMP/tree/develop)
[![license](https://img.shields.io/badge/license-OSL--3-blue.svg?style=flat-square)](https://github.com/gmdotnet/Vagrant-LAMP/blob/master/LICENSE.txt)

# Vagrant Box LAMP Stack

```                                                       
   ____ __  __     _       _              _    __     __                          _     _        _    __  __ ____  
  / ___|  \/  | __| | ___ | |_ _ __   ___| |_  \ \   / /_ _  __ _ _ __ __ _ _ __ | |_  | |      / \  |  \/  |  _ \ 
 | |  _| |\/| |/ _` |/ _ \| __| '_ \ / _ \ __|  \ \ / / _` |/ _` | '__/ _` | '_ \| __| | |     / _ \ | |\/| | |_) |
 | |_| | |  | | (_| | (_) | |_| | | |  __/ |_    \ V / (_| | (_| | | | (_| | | | | |_  | |___ / ___ \| |  | |  __/ 
  \____|_|  |_|\__,_|\___/ \__|_| |_|\___|\__|    \_/ \__,_|\__, |_|  \__,_|_| |_|\__| |_____/_/   \_\_|  |_|_|    
                                                            |___/                                                  
```

This is a DEV LAMP debian based box. Use it for a basic PHP development.

## Features

- vagrant multi machine: use for separate web, db and session machine
- choose your favourite box
- ansible playbook for your configuration
- update your file hosts automatically
- YAML config file. No more Vagrantfile to edit!
- with vagrant plugin HostsUpdater: no more /etc/hosts file to edit!

## Requirements

- virtualbox 5.x
- vagrant >1.8.4
- vagrant HostsUpdater plugin: https://github.com/cogitatio/vagrant-hostsupdater
  install with `vagrant plugin install vagrant-hostsupdater`
- (in case of error of shared folder mount errors) vagrant vagrant-vbguest plugin (install with the command `vagrant plugin install vagrant-vbguest`)

## How to use

- download https://github.com/gmdotnet/Vagrant-LAMP/archive/master.zip
- unzip on your favorite work folder
- rename `config/config.yaml.sample` in `config/config.yaml`
- change settings in `config/config.yaml`
(if you need more information about sync folder and rsync folder just have a look here: https://www.vagrantup.com/docs/synced-folders/basic_usage.html)
- run `vagrant up` on folder where is `Vagrantfile`
- (optional) make your configuration on vagrant machine entering by run `vagrant ssh`
- have fun and happy coding!

#### Provision

- enable/disable you provision script directory in your `config.yaml` file
- see the section below for more info

## OS and base box

- debian/jessie64  8.5.1
- default private network ip: 192.168.250.10

## Software Installed in `giuseppemorelli/lamp-stack` box version 1.0.1

- apache2  2.4.10
- [composer](https://getcomposer.org/)  1.2.0
- curl
- git
- [git-up](https://github.com/aanand/git-up/) (plugin for git)
- htop
- jpegoptim 1.4.1
- mailutils
- [mailhog](https://github.com/mailhog/MailHog)  0.2.0
- mc-dbg (midnight commander)
- mysql-server 5.5
- mysqltuner 1.6.0
- optipng 0.7.5
- phpmyadmin 4.6.3 - all languages (accessible via *http://phpmyadmin.vagrant* on your file host with the same ip of vagrant machine)
- postfix
- [sass](http://sass-lang.com/)  3.4.22
- tig
- xdebug

- Magento Utils:
    - [modman](https://github.com/colinmollenhour/modman) 1.12
    - [n98-magerun](https://github.com/netz98/n98-magerun)  1.97.22

- PHP
    - php5  5.6
    - php5-cli
    - php5-curl
    - php5-dev
    - php5-gd
    - php5-intl
    - php5-mcrypt
    - php5-mysql
    - php-pear

- [Node.js](https://nodejs.org/en/) 4.4.7
    - [npm](https://www.npmjs.com/)  2.15.8
    - [bower](https://bower.io/)  1.7.9
    - [LESS](http://lesscss.org/)  2.7.1
    - [CSS Lint](http://csslint.net/)  1.0.2
    - [grunt-cli](http://gruntjs.com/)  1.2.0
    - [grunt](http://gruntjs.com/)  1.0.1

### MySQL server

- created an user called `local` (password `local`) with root privilegies
- root password is `vagrant`

### Apache server

- ServerName is `vagrant`
- daemon user is `vagrant`
- root folder is `/var/www`
- mod_rewrite and mod_vhost_alias enabled
- IMPORTANT: you need to add `EnableSendfile Off` on your website configuration under <Directory "..."> </Directory> ( here all info  https://www.vagrantup.com/docs/synced-folders/virtualbox.html )

### PHP Xdebug

- auto-activated in PHP cli and PHP "web"
- IDEKEY = "VAGRANT"
- uncomment `xdebug.remote_host` in `php.ini` to enable your IDE for remote xdebug

### SMTP and EMAIL with postfix and MailHog

- postfix is configured as satellite system with 127.0.0.1:1025
- mailhog do not start automatically. Just open a shell and type `mailhog`
    - web interface is set on `<vagrant ip>:8025`
- all emails are not sent outside the machine
- to test:
    - start mailhog
    - send a test email with `echo "this is a test email | mail -s "subject test email" fake@fake.mail`
    - check on your browser `<vagrant ip>:8025` the email sent
- you can use mailhog as SMTP server, just configure your application to send email at 127.0.0.1 with port 1025

### Vagrant Provision script

- `backup_database.sh`: you can use this script as single shell script or enable it in `config.yaml` 

### Vagrant Provision Ansible Local

There is a sample ansible playbook to enable apache website.
Use it if you need to customize apache website config (like add `SetEnv` parameters)

Instructions:

- rename `ansible/playbook.yml.sample` in `ansible/playbook.yml`
- edit your `config/config.yaml` add to your rsync folder the `server/apache` folder, so you can customize without edit inside vagrant host

```
rsync:
    - folder:
        host_folder: /you/vagrant/folder/server/apache/sites-available
        vagrant_folder: /etc/apache2/sites-available
        options:
            - "-a"
            - "-r"
            - "-v"
            - "-z"
            - "--delete"
```

- edit your `config.yaml` to enable ansible provision

```
provision:
    ansible: yes
```
- start vagrant provision (automatically with new vagrant machine, with `vagrant provision` for vagrant machine previously created)

### Other info

- root password is `vagrant` but you can simply run `sudo su` from vagrant user
- if you can't find a configuration in this file before, it means is used the default value

### Credits

Giuseppe Morelli - [giuseppemorelli.net](http://www.giuseppemorelli.net)