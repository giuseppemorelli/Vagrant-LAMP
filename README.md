[![stable version](https://img.shields.io/badge/stable%20version-1.1.3-green.svg?style=flat-square)](https://github.com/gmdotnet/Vagrant-LAMP/releases/tag/1.1.3)
[![develop](https://img.shields.io/badge/beta%20version-branch%20develop-oran.svg?style=flat-square)](https://github.com/gmdotnet/Vagrant-LAMP/tree/develop)
[![license](https://img.shields.io/badge/license-OSL--3-blue.svg?style=flat-square)](https://github.com/gmdotnet/Vagrant-LAMP/blob/master/LICENSE.txt)
[![gitter](https://img.shields.io/gitter/room/nwjs/nw.js.svg)](https://gitter.im/GMdotnet/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link)

# Vagrant Box LAMP Stack

This is a DEV LAMP vagrant box and configuration. Use it for a basic PHP development.

## Features

- vagrant multi machine: use for separate web, db and session machine
- choose your favourite box, or get pre-configured box (see BOXES.md)
- ansible playbook for your configuration
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

- enable/disable your provision script directory in your `config.yaml` file
- see the section below for more info

## Vagrant boxes created

You can choose any box you want. This is a pre-configured LAMP stack. See `BOXES.md` for software installed list.

- giuseppemorelli/lamp-stack 1.0.1 (debian jessie 8.5)
- giuseppemorelli/lamp-stack 1.0.2 (debian jessie 8.6)

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

## Contribution
Any contribution is highly appreciated. The best way to contribute code is to open a [pull request on GitHub](https://help.github.com/articles/using-pull-requests).<br />Please create your pull request against the `develop` branch

### Credits

Giuseppe Morelli - [giuseppemorelli.net](http://www.giuseppemorelli.net)
