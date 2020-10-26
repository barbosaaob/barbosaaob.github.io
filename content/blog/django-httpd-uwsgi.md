title: Deploy Django with httpd(8) and uWSGI
tags: comp
category: blog
date: 2020-10-26 17:52
modified: 2020-10-26 17:52

# Django project
Django project directory structure:

	/var/www/django/
	/var/www/django/manage.py
	/var/www/django/myproject
	/var/www/django/myproject/__init__.py
	/var/www/django/myproject/urls.py
	/var/www/django/myproject/wsgi.py
	/var/www/django/myproject/wsgi.ini  <--- uwsgi config file
	/var/www/django/myproject/settings.py
	/var/www/django/myproject/asgi.py

## uwsgi.ini

	[uwsgi]
	chdir=/var/www/django
	home=/var/www/django/env
	module=myproject.wsgi:application
	env DJANGO_SETTINGS_MODULE=myproject.settings
	master=True
	fastcgi-socket=127.0.0.1:3031
	vacuum=True
	uid=www
	gid=www

## Python virtual env

	# python3 -m venv /var/www/django/env
	# . /var/www/django/env/bin/activate
	# pip install django uwsgi
	# chown -R www.www /var/www/django

# rcctl script

Create the file `/etc/rc.d/uwsgid` with the following content:

	
	#!/bin/sh
	#
	UWSGI_INI="/var/www/django/uwsgi.ini"
	PID_FILE="/var/www/django/uwsgi.pid"
	LOG_FILE="/var/www/django/uwsgi.log"

	daemon_user="www"
	daemon_group="www"
	daemon="/var/www/django/env/bin/uwsgi --ini ${UWSGI_INI} --pidfile ${PID_FILE} --daemonize ${LOG_FILE}"

	. /etc/rc.d/rc.subr

	rc_reload="NO"
	rc_stop() {
	        kill -INT `cat ${PID_FILE}`
	}

	rc_cmd $1

Make script executable: `# chmod +x /etc/rc.d/uwsgid`

# httpd(8)

Add the server config to `/etc/httpd.conf`:

	server "django" {
	    listen on egress tls port 443
	    tls {
	        certificate "/etc/ssl/server.crt"
	        key "/etc/ssl/private/server.key"
	    }
	    location "/static/*" {
	        request strip 1
	        root "/django/static"
	    }
	    location "/media/*" {
	        request strip 1
	        root "/media/media"
	    }
	    location "/*" {
	        fastcgi socket tcp 127.0.0.1 3031
	    }
	}

(using the new httpd(8) fastcgi syntax from OpenBSD 6.8)


# OpenBSD semafores

	# sysctl kern.seminfo.semmni=20
	# sysctl kern.seminfo.semmns=120
	# sysctl kern.seminfo.semmnu=60
	# sysctl kern.seminfo.semmsl=120
	# sysctl kern.seminfo.semopm=200

Add the lines below to `/etc/sysctl.conf` to make the changes persistent:

	kern.seminfo.semmni=20
	kern.seminfo.semmns=120
	kern.seminfo.semmnu=60
	kern.seminfo.semmsl=120
	kern.seminfo.semopm=200

# Start httpd(8) and uWSGI

	# rcctl enable httpd uwsgid
	# rcctl start httpd uwsgid
	
# Debugging uWSGI errors
uWSGI log file is located in `/var/www/django/uwsgi.log`.
