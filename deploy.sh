#!/bin/bash

exit_trap () {
  local lc="$BASH_COMMAND" rc=$?
  exec 1>&5 2>&6
  echo ""
  echo "Deployment failed at command [$lc] with exit code [$rc]"
  echo "See deploy.log for details"
}

trap exit_trap ERR
set -e

if [[ "$UID" -ne "0" ]]; then
	echo "Please run this script as administrator."
	exit 1
fi

WWW_DIR=/var/www/piccoleau.ch
LOG_DIR=/var/log/apache2/piccoleau.ch

echo "Deploying web site to $WWW_DIR"

{
	echo -n "Cleaning working directory..." >&5
	su -c "git pull && git reset --hard && git clean -fdx" tmonney
	echo "done" >&5

	echo -n "Cleaning build directory..." >&5
	grunt clean
	echo "done" >&5
	
	echo -n "Building site..." >&5
	grunt
	echo "done" >&5

	echo -n "Preparing target directories..." >&5
	mkdir -p $WWW_DIR
	mkdir -p $LOG_DIR
	echo "done" >&5

	echo -n "Copying files to target directory" >&5
	cp -R bin/* $WWW_DIR
	chown -R www-data:www-data $WWW_DIR
	echo "done" >&5

	echo -n "Configuring Apache virtual host" >&5
	cp apache/piccoleau.ch.conf /etc/apache2/sites-available/
	a2ensite piccoleau.ch.conf
	echo "done" >&5

	echo -n "Reload Apache configuration" >&5
	service apache2 reload
	echo "done" >&5

} 5>&1 6>&2 1>deploy.log 2>&1

echo "Successfully deployed web site to $WWW_DIR"
