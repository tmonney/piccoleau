server {
	listen 80 default_server;
	listen [::]:80 default_server ipv6only=on;

	root /var/www/piccoleau.ch;
	server_name piccoleau.ch www.piccoleau.ch;

	access_log /var/log/nginx/piccoleau.ch/access.log;
	error_log /var/log/nginx/piccoleau.ch/error.log info;
	rewrite_log on;

	location = / {
		if ($query_string ~* "^_escaped_fragment_=/?$") {
			rewrite ^.*$ /snapshots/home.html last;
		}
		if ($query_string ~* "^_escaped_fragment_=/(.+)$") {
			set $p $1;
			rewrite ^.*$ /snapshots/$p.html last;
		}
	}

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;
	}

	location /snapshots/assets/ {
		rewrite ^/snapshots(/assets/.*)$ $1;
	}

	location ~ \.php$ {
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
		# NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
	
		# With php5-fpm:
		fastcgi_pass unix:/var/run/php5-fpm.sock;
		fastcgi_index index.php;
		include fastcgi_params;
	}
}
