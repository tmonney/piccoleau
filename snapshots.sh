#!/bin/bash

phantomjs --disk-cache=no seo-server.js 8888 "file://$(pwd)/bin/index.html" &
PID=$!

sleep 2

echo "PID is $PID"

SNAPSHOTS=bin/snapshots
mkdir -p $SNAPSHOTS

for page in $(cat src/assets/sitemap.txt); do
	path=$(python -c "from urlparse import urlparse; print(urlparse('$page').fragment[1:])")
	echo "Processing path $path"
	curl --silent "http://localhost:8888/?_escaped_fragment_=$path" > "$SNAPSHOTS$path.html"
done

echo "Killing PhantomJS process [$PID]"
kill $PID
