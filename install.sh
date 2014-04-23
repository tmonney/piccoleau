#!/usr/bin/env bash

apt-get update -y && apt-get upgrade -y
apt-get install -y software-properties-common
apt-add-repository ppa:chris-lea/node.js
apt-get update -y && apt-get install -y nodejs git phantomjs
npm install -g grunt-cli karma bower
npm install