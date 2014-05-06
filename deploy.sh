#!/bin/bash

WWW_DIR=/var/www/piccoleau.ch/
LOG_DIR=/var/log/nginx/piccoleau.ch/
AV_SITE_DIR=/etc/nginx/sites-available/
EN_SITE_DIR=/etc/nginx/sites-enabled/
DEPLOY_LOG=deploy.log

red=`tput setaf 1`
green=`tput setaf 2`
normal=`tput sgr0`

[[ -f $DEPLOY_LOG ]] && rm $DEPLOY_LOG

print_status() {
	msg="$1..."
	status="[$2]"
	color="$3"
	let col=$(tput cols)-${#msg}+${#color}+${#normal}-1
	printf "%${col}s\n" "$color$status$normal"
}

step() {
	cmd=$1
	msg=$2

	echo -n "$msg..."
	$cmd >> $DEPLOY_LOG 2>&1
	exit_code=$?
	if [[ "$exit_code" -eq "0" ]]; then
		print_status "$msg" "OK" "$green"
	else
		print_status "$msg" "FAILED" "$red"
		echo ""
		echo "Deployment failed at command [$cmd] with exit code [$exit_code]"
		echo "See deploy.log for details"
		exit 1
	fi
	
}

# Ask the password at the beginning
sudo true

step 'git pull'                                           "Getting web site latest version"
step 'npm install'                                        "Preparing build environment"
step 'bower install'                                      "Getting build dependencies"
step 'grunt clean'                                        "Cleaning build directory"
step 'grunt'                                              "Building site"
step './snapshots.sh'                                     "Generating HTML snapshots for search engines"
step "sudo mkdir -p $WWW_DIR $LOG_DIR"                    "Preparing target directories"
step "sudo cp -R bin/* $WWW_DIR"                          "Copying files to target directory"
step "sudo chown -R www-data:www-data $WWW_DIR"           "Fixing permissions"
step "sudo cp nginx/piccoleau.ch $AV_SITE_DIR"            "Copying virtual host configuration"
step "sudo ln -sf $AV_SITE_DIR/piccoleau.ch $EN_SITE_DIR" "Enabling virtual host"
step 'sudo service nginx reload'                          "Reloading Nginx configuration"

echo "Successfully deployed web site to $WWW_DIR"
