# Nginx

	rm /etc/nginx/sites-enabled/default
		# Delete softlink to default if you don't need to use it.
	rm /etc/nginx/sites-available/default
		# Delete default alltogether if you don't use it.	
	date > /var/www/html/contfix.co.il/1.html
		# Access the site to check if the server handles requests (a simple HTML file will tell us this directly).
	echo '<?php phpinfo();' > /var/www/html/contfix.co.il/1.php
		# Access the site to check if the server references requests to PHP.

	# Only hompage insecure? Find and replace.

	# nginx.conf:
		user www-data; # start of nginx.conf. # sed
		client_max_body_size 200M; # End of http{}. #sed

	# Certbot:
		csb domain.tld
		certbot --nginx
		0 0 * * * certbot renew  

	# Background data:
		A Unix socket is the interface between 2 or more processes.
		A TCP/IP socket is the interface between a process and 1 connector, or more.
		
		CGI, for all its types, is the interface between a webserver and a backend feature.
			Client action > Server request > CGI of some type > Backend action (whatever the result is for the browser).
				A CGI of any kind is a unix socket because it is an iterface between two or more processes (the webserver) and (other processes like PHP).

		PHP-FPM is a FastCGI for PHP (if the request is done for data constructed from PHP, this is relevant).
			php-fpm and mod_php (with underscore) are two basic ways to run PHP.
				mod_SuPHP is similar to mod_php but can change the user/group that the process runs under.
		
		Nginx is a reverse proxy because it both gets requesets from the user, and bring the user internal data from a CGI.
			Think of Nginx like a big huge M (one tip is the client, the middle is Nginx, and the other tip is the CGI).
				Actually it would best be called bilateral proxy instead just forward proxy or reverse proxy, but reverse here is bilateral.
