FROM php:5.6-apache

COPY sources.list /etc/apt/sources.list
RUN apt-get update -y --force-yes && \
    apt-get install -y git && \
    apt-get install -y --force-yes libapache2-mod-authnz-external && \
	rm -rf /var/lib/apt/lists/*
 
RUN a2enmod rewrite

ENV GITLIST_VERSION 0.5.0

RUN mkdir -p /home/git/repositories/ \
        && cd /home/git/repositories/ \
        && git --bare init foo

RUN curl -o /tmp/gitlist.tar.gz -SL https://github.com/klaussilveira/gitlist/archive/${GITLIST_VERSION}.tar.gz \
        && tar -xzf /tmp/gitlist.tar.gz -C /tmp/ \
		&& mv /tmp/gitlist-${GITLIST_VERSION}/.htaccess /tmp/gitlist-${GITLIST_VERSION}/* /var/www/html/ \
		&& rm -rf /tmp/gitlist-${GITLIST_VERSION} /tmp/gitlist.tar.gz \
        && chown -R www-data:www-data /var/www/html/ \
        && cd /var/www/html/ \
        && chmod 777 cache \
        && cp /var/www/html/config.ini-example /var/www/html/config.ini

VOLUME /var/www/html
WORKDIR /var/www/html/

RUN a2enmod actions ;\
    a2enmod authnz_ldap ;\
    a2enmod authnz_external ;\
    a2enmod ldap ;\
    a2enmod setenvif

ENTRYPOINT  ["apache2ctl", "-D", "FOREGROUND"]
