#!/bin/bash

phantomjs --disk-cache=no vendor/angular-seo/angular-seo-server.js 8888 http://localhost:80/ &
PID=$!

sleep 2

echo "PID is $PID"

SNAPSHOTS=bin/snapshots
mkdir -p $SNAPSHOTS

for page in $(cat src/assets/sitemap.txt); do
	echo "Processing page $page"
	path=$(python -c "from urlparse import urlparse; print(urlparse('$page').path)")

	curl --silent "http://localhost:8888/?_escaped_fragment_=$path" > "$SNAPSHOTS$path.html"
done

echo "Killing PhantomJS process [$PID]"
kill $PID
