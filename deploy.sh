#!/bin/bash

if [[ "$UID" -ne "0" ]]; then
	echo "Please run this script as administrator."
	exit 1
fi

su -c "git pull && git reset --hard && git clean -fdx" tmonney

WWW_DIR=/var/www/piccoleau.ch
LOG_DIR=/var/log/apache2/piccoleau.ch

grunt clean
grunt

mkdir -p $WWW_DIR
mkdir -p $LOG_DIR

cp -R bin/* $WWW_DIR
chown -R www-data:www-data $WWW_DIR
