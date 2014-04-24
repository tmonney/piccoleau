#!/bin/bash

exit_trap () {
  local lc="$BASH_COMMAND" rc=$?
  exec 1>&5 2>&6
  echo "Deployment failed at command [$lc] (exit code [$rc])"
  echo "See debug.log for details"
}

trap exit_trap ERR
set -e

if [[ "$UID" -ne "0" ]]; then
	echo "Please run this script as administrator."
	exit 1
fi

{
	su -c "git pull && git reset --hard && git clean -fdx" tmonney

	WWW_DIR=/var/www/piccoleau.ch
	LOG_DIR=/var/log/apache2/piccoleau.ch

	grunt clean
	grunt

	mkdir -p $WWW_DIR
	mkdir -p $LOG_DIR

	cp -R bin/* $WWW_DIR
	chown -R www-data:www-data $WWW_DIR
} 5>&1 6>&2 1>deploy.log 2>&1
